#!/usr/bin/env bash

# сборка проекта

# запись коммитов в тикет
PREV_TAG=$(git describe --abbrev=0 --tags $CURRENT_TAG^) #предыдущий релиз

echo "$CURRENT_TAG"
echo "$PREV_TAG"

if [[ $PREV_TAG ]]; then
  echo "$CURRENT_TAG and $PREV_TAG"
  # берем коммиты между двумя
  RESULT=$(git log $CURRENT_TAG...$PREV_TAG --pretty=format:"%h %an %s" | tr '\n' ';' | sed 's/;/ - /')
else
  # берем все коммиты
  RESULT=$(git log $CURRENT_TAG --pretty=format:"%h %an %s" | tr '\n' ';' | sed 's/;/ - /')
fi

# форматирование коммитов в одну строку
RESULT_TMP=""
echo "$RESULT" | while read line; do
  echo "line: "$line
  RESULT_TMP=$RESULT_TMP$line'\n'
  echo $RESULT_TMP > log.txt
done
RESULT_ONE_LINE=$(cat log.txt)
rm -rf log.txt

# отправляем запрос
TICKET_TITLE='{"summary": "Релиз '"$CURRENT_TAG"' - '$(date +%d/%m/%Y)'", "description": "Ответственный за релиз: '$TAG_AUTHOR'\n\n Коммиты, попавшие в релиз:\n'$RESULT_ONE_LINE'"}'
COMMENT_TEXT='{"text": "Собрали релиз '$CURRENT_TAG'"}'
curl -X PATCH https://api.tracker.yandex.net/v2/issues/HOMEWORKSHRI-161/ -H "Authorization: OAuth $OAUTH_TOKEN" -H "X-Org-ID: $X_ORG_ID" -H "Content-type: application/json" -d "$TICKET_TITLE"
curl -X POST https://api.tracker.yandex.net/v2/issues/HOMEWORKSHRI-161/comments -H "Authorization: OAuth $OAUTH_TOKEN" -H "X-Org-ID: $X_ORG_ID" -H "Content-type: application/json" -d "$COMMENT_TEXT"

exit 0