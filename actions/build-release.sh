#!/usr/bin/env bash

# сборка проекта

RESULT=$(git log --pretty=format:"%h\%an\%s;")
echo ${RESULT}

echo 'ref'
echo ${GITHUB-REF}

exit 0
