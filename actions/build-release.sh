#!/usr/bin/env bash

# сборка проекта

RESULT=$(git log --pretty=format:"%h\%an\%s;")
echo ${RESULT}

echo 'ref'
echo ${{ github.context.ref_name }}

echo 'sha'
echo ${{ github.context.ref_name }}

exit 0
