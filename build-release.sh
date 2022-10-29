#!/usr/bin/env bash

# TS check project
npm run ts

echo "Start ts check"

if [ "$?" != "0" ]; then
  echo "Failed ts check" >&2
  exit 1
fi
echo "End ts check"
exit 0
