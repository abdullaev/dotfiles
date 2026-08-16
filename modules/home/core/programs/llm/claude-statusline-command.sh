# shellcheck shell=bash
# No shebang: this file is embedded into a writeShellScript in default.nix.
input=$(cat)

# Every field in one jq pass — the statusline runs on each UI refresh, so one
# spawn instead of ten matters. Fields are joined on the unit separator, not
# @tsv: tab is IFS whitespace, so `read` would collapse empty fields (absent
# rate limits, null used_percentage) and shift the rest left.
IFS=$'\x1f' read -r model cost_usd transcript used_pct ctx_size current_input cache_read rate_5h reset_5h rate_7d reset_7d <<<"$(echo "$input" | jq -r '[
  (.model.display_name // "Unknown Model"),
  (.cost.total_cost_usd // 0),
  (.transcript_path // ""),
  (.context_window.used_percentage // ""),
  (.context_window.context_window_size // 0),
  # input + cache_read + cache_creation = total context used
  ((.context_window.current_usage.input_tokens // 0)
    + (.context_window.current_usage.cache_read_input_tokens // 0)
    + (.context_window.current_usage.cache_creation_input_tokens // 0)),
  # cache_read = served from cache this request
  (.context_window.current_usage.cache_read_input_tokens // 0),
  # rate limits exist in subscription mode only — absent in API mode
  (.rate_limits.five_hour.used_percentage // ""),
  (.rate_limits.five_hour.resets_at // ""),
  (.rate_limits.seven_day.used_percentage // ""),
  (.rate_limits.seven_day.resets_at // "")
] | map(tostring) | join("\u001f")')"

cost_display=$(printf '$%.2f' "$cost_usd")

# Session duration: prefer first transcript entry's timestamp (FS birth time
# is unreliable on ext4, and mtime is meaningless because the jsonl is
# appended to). GNU date/stat only — the wrapper pins coreutils into PATH.
if [ -n "$transcript" ] && [ -f "$transcript" ]; then
  start_time=""
  # First line is often a meta entry (permissionMode/sessionId/type) without
  # a timestamp, so scan the first few lines for the first one that has it.
  start_iso=$(head -n 50 "$transcript" 2>/dev/null | jq -r 'select(.timestamp) | .timestamp' 2>/dev/null | head -n 1)
  if [ -n "$start_iso" ]; then
    start_time=$(date -d "$start_iso" +%s 2>/dev/null || echo "")
  fi
  if [ -z "$start_time" ]; then
    start_time=$(stat -c "%W" "$transcript" 2>/dev/null || echo "")
    case "$start_time" in '' | *[!0-9]*) start_time="" ;; esac
    if [ -z "$start_time" ] || [ "$start_time" = "0" ]; then
      start_time=$(stat -c "%Y" "$transcript" 2>/dev/null || echo "")
      case "$start_time" in '' | *[!0-9]*) start_time="" ;; esac
    fi
  fi
  now=$(date +%s)
  if [ -n "$start_time" ] && [ "$start_time" != "0" ]; then
    elapsed=$((now - start_time))
    hours=$((elapsed / 3600))
    minutes=$(((elapsed % 3600) / 60))
    if [ "$hours" -gt 0 ]; then
      duration="${hours}h${minutes}m"
    else
      duration="${minutes}m"
    fi
  else
    duration="?"
  fi
else
  duration="?"
fi

# Context window (values in K)
cache_k=$((cache_read / 1000))
ctx_k=$((ctx_size / 1000))

# If used_percentage is null but we have token counts, compute it ourselves
# (pure bash arithmetic — avoids `bc`, which isn't installed on minimal Ubuntu)
if [ -z "$used_pct" ] && [ "$ctx_size" -gt 0 ] && [ "$current_input" -gt 0 ]; then
  used_pct=$((current_input * 100 / ctx_size))
fi

if [ -n "$used_pct" ] && [ "$used_pct" != "0" ]; then
  pct_int=$(printf "%.0f" "$used_pct")
  ctx_k_used=$((current_input / 1000))
  if [ "$pct_int" -lt 50 ]; then
    pct_colored="\033[32m${pct_int}%\033[0m"
  elif [ "$pct_int" -lt 80 ]; then
    pct_colored="\033[33m${pct_int}%\033[0m"
  else
    pct_colored="\033[31m${pct_int}%\033[0m"
  fi
  ctx_display="${ctx_k_used}k/${ctx_k}k ${pct_colored}"
else
  ctx_display="0/${ctx_k}k 0%"
fi

color_pct() {
  local pct_int
  pct_int=$(printf "%.0f" "$1")
  if [ "$pct_int" -lt 75 ]; then
    printf "\033[32m%s%%\033[0m" "$pct_int"
  elif [ "$pct_int" -lt 90 ]; then
    printf "\033[33m%s%%\033[0m" "$pct_int"
  else
    printf "\033[31m%s%%\033[0m" "$pct_int"
  fi
}

fmt_reset() {
  local target="$1"
  case "$target" in '' | *[!0-9]*) return 0 ;; esac
  local now remaining h m
  now=$(date +%s)
  remaining=$((target - now))
  [ "$remaining" -le 0 ] && {
    printf "0s"
    return 0
  }
  h=$((remaining / 3600))
  m=$(((remaining % 3600) / 60))
  local d=$((h / 24))
  local hr=$((h % 24))
  if [ "$d" -gt 0 ]; then
    printf "%dd%dh" "$d" "$hr"
  elif [ "$h" -gt 9 ]; then
    printf "%dh" "$h"
  elif [ "$h" -gt 0 ]; then
    printf "%dh%dm" "$h" "$m"
  elif [ "$m" -gt 0 ]; then
    printf "%dm" "$m"
  else
    printf "%ds" "$remaining"
  fi
}

limits_display=""
if [ -n "$rate_5h" ] || [ -n "$rate_7d" ]; then
  part_5h=""
  part_7d=""
  if [ -n "$rate_5h" ]; then
    part_5h="5h:$(color_pct "$rate_5h")"
    left_5h=$(fmt_reset "$reset_5h")
    [ -n "$left_5h" ] && part_5h="${part_5h}\033[2m(${left_5h})\033[0m"
  fi
  if [ -n "$rate_7d" ]; then
    part_7d="7d:$(color_pct "$rate_7d")"
    left_7d=$(fmt_reset "$reset_7d")
    [ -n "$left_7d" ] && part_7d="${part_7d}\033[2m(${left_7d})\033[0m"
  fi
  if [ -n "$part_5h" ] && [ -n "$part_7d" ]; then
    limits_display="  \033[2mlimits:\033[0m ${part_5h}  ${part_7d}"
  elif [ -n "$part_5h" ]; then
    limits_display="  \033[2mlimits:\033[0m ${part_5h}"
  else
    limits_display="  \033[2mlimits:\033[0m ${part_7d}"
  fi
fi

# Colors
CYAN="\033[36m"
DIM="\033[2m"
RESET="\033[0m"
BOLD="\033[1m"

printf "${BOLD}${CYAN}%s${RESET}  ${DIM}session:${RESET} %s  ${DIM}cost:${RESET} %s  ${DIM}ctx:${RESET} %b  ${DIM}cache:${RESET} %sk%b" \
  "$model" \
  "$duration" \
  "$cost_display" \
  "$ctx_display" \
  "$cache_k" \
  "$limits_display"
