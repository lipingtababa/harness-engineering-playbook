#!/usr/bin/env bash
# Test: verify zh and en chapter directories are in sync
set -euo pipefail

root="$(cd "$(dirname "$0")/.." && pwd)"
errors=0

# Check that every chapter file in zh/ has a corresponding file in en/ and vice versa
for file in "$root"/zh/chapters/*.md; do
  basename="$(basename "$file")"
  if [ ! -f "$root/en/chapters/$basename" ]; then
    echo "ERROR: zh/chapters/$basename exists but en/chapters/$basename is missing"
    errors=$((errors + 1))
  fi
done

for file in "$root"/en/chapters/*.md; do
  basename="$(basename "$file")"
  if [ ! -f "$root/zh/chapters/$basename" ]; then
    echo "ERROR: en/chapters/$basename exists but zh/chapters/$basename is missing"
    errors=$((errors + 1))
  fi
done

if [ "$errors" -gt 0 ]; then
  echo "$errors sync error(s) found"
  exit 1
fi

echo "zh/en chapter files are in sync"
