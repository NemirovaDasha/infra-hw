#!/usr/bin/env bash

# сборка проекта

RESULT=$(git log --pretty=format:"%h\%an\%s;")
echo ${RESULT}

echo 'ref'
echo "$GITHUB_REF_NAME"

exit 0
