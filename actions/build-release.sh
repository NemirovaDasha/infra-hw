#!/usr/bin/env bash

# сборка проекта

# запись коммитов в тикет
#CURRENT_TAG=$GITHUB_REF_NAME
#PREV_TAG=$(git describe --abbrev=0 --tags $CURRENT_TAG^) #предыдущий релиз
#
#echo "$CURRENT_TAG"
#echo "$PREV_TAG"
#
#if [[ $PREV_TAG ]]; then
#  echo "$CURRENT_TAG and $PREV_TAG"
#  # берем коммиты между двумя
#  RESULT=$(git log $CURRENT_TAG...$PREV_TAG --pretty=format:"%h %an %s" | tr '\n' ';' | sed 's/;/ - /')
#else
#  # берем все коммиты
#  RESULT=$(git log $CURRENT_TAG --pretty=format:"%h %an %s" | tr '\n' ';' | sed 's/;/ - /')
#fi
#
## результат для запроса
#TICKET_TITLE='{"summary": "Релиз '"$CURRENT_TAG"' - '$(date +%d/%m/%Y)'"}'
#COMMENT_TEXT='{"text": "'"$RESULT"'"}'
#echo "result:"
#echo "$COMMENT_TEXT"
#curl -X PATCH https://api.tracker.yandex.net/v2/issues/HOMEWORKSHRI-161/ -H "Authorization: OAuth $OAUTH_TOKEN" -H "X-Org-ID: $X_ORG_ID" -H "Content-type: application/json" -d "$TICKET_TITLE"
#curl -X POST https://api.tracker.yandex.net/v2/issues/HOMEWORKSHRI-161/comments -H "Authorization: OAuth $OAUTH_TOKEN" -H "X-Org-ID: $X_ORG_ID" -H "Content-type: application/json" -d "$COMMENT_TEXT"
#
#exit 0

RESULT=$(git log rc-0.0.12...rc-0.0.11 --pretty=format:"%h %an %s")
TICKET_PARAMS='{"summary": "Релиз '"$CURRENT_TAG"' - '$(date +%d/%m/%Y)'", "description": '"$RESULT"'}'
COMMENT_TEXT='{"text": "Собрали релиз"}'
echo "$COMMENT_TEXT"
echo "$TICKET_PARAMS"
curl -X PATCH https://api.tracker.yandex.net/v2/issues/HOMEWORKSHRI-161/ -H "Authorization: OAuth y0_AgAAAAAqqHAwAAiJvgAAAADSm5rhknpbiX-5TaGknNo6E3noSr31PpA" -H "X-Org-ID: 7526988" -H "Content-type: application/json" -d "$TICKET_PARAMS"
curl -X POST https://api.tracker.yandex.net/v2/issues/HOMEWORKSHRI-161/comments -H "Authorization: OAuth y0_AgAAAAAqqHAwAAiJvgAAAADSm5rhknpbiX-5TaGknNo6E3noSr31PpA" -H "X-Org-ID: 7526988" -H "Content-type: application/json" -d "$COMMENT_TEXT"
