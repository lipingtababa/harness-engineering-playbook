#!/usr/bin/env bash
# Lint: verify all chapter files referenced in SUMMARY.md actually exist
set -euo pipefail

root="$(cd "$(dirname "$0")/.." && pwd)"
errors=0

for lang in zh en; do
  summary="$root/$lang/SUMMARY.md"
  if [ ! -f "$summary" ]; then
    echo "WARN: $summary not found, skipping"
    continue
  fi

  # Extract markdown link targets (paths in parentheses)
  grep -oE '\(chapters/[^)]+\)' "$summary" | tr -d '()' | while read -r path; do
    full="$root/$lang/$path"
    if [ ! -f "$full" ]; then
      echo "ERROR: $lang/SUMMARY.md references '$path' but file does not exist"
      exit 1
    fi
  done
done

echo "All SUMMARY.md references OK"
