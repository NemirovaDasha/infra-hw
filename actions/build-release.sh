#!/usr/bin/env bash

# run ts check
./actions/ts-check.sh

# run linter check
./actions/linter-check.sh

# сборка проекта

#RESULT=$(git log --pretty=format:"%h %an %s")
#echo ${RESULT}

exit 0
