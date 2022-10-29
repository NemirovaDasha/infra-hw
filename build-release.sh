#!/usr/bin/env bash

# TS check project
echo "Start ts check"
npm run ts

if [ "$?" != "0" ]; then
  echo "Failed ts check" >&2
  exit 1
fi
echo "End ts check"
exit 0
