#!/usr/bin/env bash

# Check ts files
echo "[INFO] Start ts check"
npm run ts

if [ "$?" != "0" ]; then
  echo "[ERROR] Failed ts check" >&2
  exit 0
fi

echo "[SUCCESS] End ts check"
exit 0
