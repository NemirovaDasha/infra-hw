#!/usr/bin/env bash

# сборка проекта

# запись коммитов в тикет
CURRENT_TAG=$GITHUB_REF_NAME
PREV_TAG=$(git describe --abbrev=0 --tags $CURRENT_TAG^) #предыдущий релиз

echo "$CURRENT_TAG"
echo "$PREV_TAG"

if [[ $PREV_TAG ]]; then
  echo "$CURRENT_TAG and $PREV_TAG"
  # берем коммиты между двумя
  RESULT=$(git log $CURRENT_TAG...$PREV_TAG --pretty=format:"%h %an %s")
else
  # берем все коммиты
  RESULT=$(git log $CURRENT_TAG --pretty=format:"%h %an %s")
fi

COMMENT_TEXT='{"text": "'"$RESULT"'"}'
echo "result:"
echo "$COMMENT_TEXT"
curl -X POST https://api.tracker.yandex.net/v2/issues/HOMEWORKSHRI-161/comments -H "Authorization: OAuth $OAUTH_TOKEN" -H "X-Org-ID: $X_ORG_ID" -H "Content-type: application/json" -d "$COMMENT_TEXT"

exit 0
