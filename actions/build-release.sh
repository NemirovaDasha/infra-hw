#!/usr/bin/env bash

# сборка проекта

# запись коммитов в тикет
CURRENT_TAG=$GITHUB_REF_NAME
TAG_NUM=${GITHUB_REF_NAME:7} #последняя цифра релиза
PREV_TAG_NUM=$(expr $TAG_NUM - 1) #последняя цифра предыдущего релиза
PREV_TAG="rc-0.0.$PREV_TAG_NUM" #предыдущий релиз

IS_PREV_TAG=$(git tag | grep "rc-0.0.$PREV_TAG_NUM")
echo "$CURRENT_TAG"
echo "$PREV_TAG"

if [[ -n $IS_PREV_TAG ]]; then
  # берем коммиты между двумя
  RESULT=$(git log $CURRENT_TAG...$PREV_TAG --pretty=format:"%h %an %s")
else
  # берем все коммиты
  RESULT=$(git log $CURRENT_TAG --pretty=format:"%h %an %s")
  echo "false"
fi

COMMENT_TEXT={"text": "$RESULT"}

curl -X POST https://api.tracker.yandex.net/v2/issues/HOMEWORKSHRI-161/comments -H "Authorization: OAuth $OAUTH_TOKEN" -H "X-Org-ID: $X_ORG_ID" -H "Content-type: application/json" -d "$COMMENT_TEXT"

exit 0
