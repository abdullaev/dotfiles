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

die() {
  echo "cachix-push: $*" >&2
  exit 1
}

[ -s candidates.txt ] || die "no locally-built paths found; did the build run?"
grep -E -- "$(join "${ignored[@]}")" candidates.txt >bad.txt || true
# Safety stop: if the non-redistributable font ever stops matching its
# ignore pattern (rename upstream), abort rather than risk pushing it.
grep -q pragmata bad.txt || die "pragmata not matched by ignore patterns; check the ignored list"
grep -E -- "$(join "${aggregates[@]}")" candidates.txt >>bad.txt ||
  die "no aggregate paths matched; nixpkgs/home-manager suffixes changed?"
xargs nix-store -q --referrers-closure <bad.txt | sort -u >excluded.txt
comm -23 candidates.txt excluded.txt | tee pushed.txt | cachix push "$CACHIX_CACHE"
echo "Offered $(wc -l <pushed.txt) paths to cachix ($(wc -l <excluded.txt) excluded: non-redistributable, aggregates, or referrers thereof)"
