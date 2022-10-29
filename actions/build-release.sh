#!/usr/bin/env bash

# run ts check
./actions/ts-check.sh

# run linter check
./actions/linter-check.sh

# сборка проекта
git log --pretty=format:"%h - %an, %ar : %s"

exit 0

