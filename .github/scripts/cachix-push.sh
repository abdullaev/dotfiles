#!/usr/bin/env bash
# Push locally-built store paths to $CACHIX_CACHE. Runs in CI after the
# full system build, with the complete closure in the local store.

set -euo pipefail

nix path-info --all --json | jq -r 'to_entries[]
  | select(.key | endswith(".drv") | not)
  | select(.key | test("-source$") | not)
  | select((.value.ca // "") == "")
  | select(((.value.signatures // []) | map(startswith("cache.nixos.org")) | any) | not)
  | .key' | sort -u >candidates.txt
[ -s candidates.txt ]
grep -E 'pragmata|google-chrome|obsidian' candidates.txt >bad.txt || true
grep -q pragmata bad.txt
grep -E -- '-nixos-system-|-system-path$|-etc$|-nixos-hosts-checks$|-home-manager-generation$|-home-manager-path$' \
  candidates.txt >>bad.txt
xargs nix-store -q --referrers-closure <bad.txt | sort -u >excluded.txt
comm -23 candidates.txt excluded.txt | tee pushed.txt | cachix push "$CACHIX_CACHE"
echo "Offered $(wc -l <pushed.txt) paths to cachix ($(wc -l <excluded.txt) excluded: non-redistributable, aggregates, or referrers thereof)"
