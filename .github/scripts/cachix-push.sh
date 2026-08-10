#!/usr/bin/env bash
# Push locally-built store paths to $CACHIX_CACHE. Runs in CI after the
# full system build, with the complete closure in the local store.

set -euo pipefail

ignored=(
  pragmata
  google-chrome
  obsidian
)

aggregates=(
  '-nixos-system-'
  '-system-path$'
  '-etc$'
  '-nixos-hosts-checks$'
  '-home-manager-generation$'
  '-home-manager-path$'
)

join() {
  local IFS='|'
  echo "$*"
}

nix path-info --all --json | jq -r 'to_entries[]
  | select(.key | endswith(".drv") | not)
  | select(.key | test("-source$") | not)
  | select((.value.ca // "") == "")
  | select(((.value.signatures // []) | map(startswith("cache.nixos.org")) | any) | not)
  | .key' | sort -u >candidates.txt
[ -s candidates.txt ]
grep -E -- "$(join "${ignored[@]}")" candidates.txt >bad.txt || true
grep -q pragmata bad.txt
grep -E -- "$(join "${aggregates[@]}")" candidates.txt >>bad.txt
xargs nix-store -q --referrers-closure <bad.txt | sort -u >excluded.txt
comm -23 candidates.txt excluded.txt | tee pushed.txt | cachix push "$CACHIX_CACHE"
echo "Offered $(wc -l <pushed.txt) paths to cachix ($(wc -l <excluded.txt) excluded: non-redistributable, aggregates, or referrers thereof)"
