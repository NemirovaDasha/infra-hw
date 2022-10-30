#!/usr/bin/env bash

# сборка проекта

#RESULT=$(git log --pretty=format:"%h\%an\%s;")
#echo ${RESULT}
API_TRACKER = https://api.tracker.yandex.net/v2/myself

CURRENT_TAG=$GITHUB_REF_NAME
TAG_NUM=${GITHUB_REF_NAME:7} #последняя цифра релиза
PREV_TAG_NUM=$(expr $TAG_NUM - 1) #последняя цифра предыдущего релиза
PREV_TAG="rc-0.0.$PREV_TAG_NUM" #предыдущий релиз

IS_PREV_TAG=$(git tag | grep "rc-0.0.$PREV_TAG_NUM")
echo "$CURRENT_TAG"
echo "$PREV_TAG"

curl -X GET $API_TRACKER -H "Authorization: OAuth $OAUTH_TOKEN" -H "X-Org-ID: $X_ORG_ID"

#if [[ -n $IS_PREV_TAG ]]; then
  #берем коммиты между двумя
#  echo "$PREV_TAG"
#else
#  берем все коммиты
#  echo "false"
#fi

exit 0
