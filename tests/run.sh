#!/usr/bin/env bash
# Auto-generated test harness — run after cloning to verify the build.
set -uo pipefail
FAIL=0

echo "-- syntax/build check --"
if luac -p tiny-mask.lua 2>/dev/null || lua -e 'assert(loadfile("tiny-mask.lua"))'; then echo "  ok"; else echo "  FAIL"; FAIL=1; fi

echo "-- functional check --"
OUT="$(lua tiny-mask.lua 2>&1)"
if echo "$OUT" | grep -qF -- 'Solved in'; then
  echo "  ok   - contains: Solved in"
else
  echo "  FAIL - expected to contain: Solved in"
  echo "  got: $OUT"
  FAIL=1
fi

if [ "$FAIL" = "1" ]; then echo; echo "FAILED"; exit 1; fi
echo; echo "All tests passed."
