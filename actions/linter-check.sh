#!/usr/bin/env bash

# Check linter files
echo "[INFO] Start linter check"
npm run lint

if [ "$?" != "0" ]; then
  echo "[ERROR] Failed linter check" >&2
  exit 0
fi

echo "[SUCCESS] End linter check"
exit 0
