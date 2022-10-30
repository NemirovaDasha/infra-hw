#!/usr/bin/env bash

# запись коммитов в тикет
echo "[INFO] Start make release ticket"
PREV_TAG=$(git describe --abbrev=0 --tags $CURRENT_TAG^) #предыдущий релиз

echo "[INFO] Get release commits"
if [[ $PREV_TAG ]]; then
  # берем коммиты между двумя
  echo "[INFO] Get commits between $CURRENT_TAG and $PREV_TAG"
  RESULT=$(git log $CURRENT_TAG...$PREV_TAG --pretty=format:"%h - %an - %s")
else
  # берем все коммиты
  echo "[INFO] Get commits from start to $CURRENT_TAG"
  RESULT=$(git log $CURRENT_TAG --pretty=format:"%h - %an - %s")
fi
echo "[INFO] End get release commits"

# форматирование коммитов в одну строку
echo "[INFO] Format release commits string"
RESULT_TMP=""
echo "$RESULT" | while read line; do
  echo "line: "$line
  RESULT_TMP=$RESULT_TMP$line'\n'
  echo $RESULT_TMP > log.txt
done
RESULT_ONE_LINE=$(cat log.txt)
rm -rf log.txt
echo "[INFO] End format release commits string"

# отправляем запрос
echo "[INFO] Start post request to release ticket"
TICKET_TITLE='{"summary": "Релиз '"$CURRENT_TAG"' - '$(date +%d/%m/%Y)'", "description": "Ответственный за релиз: '$TAG_AUTHOR'\n\n Коммиты, попавшие в релиз:\n'$RESULT_ONE_LINE'"}'
curl -X PATCH https://api.tracker.yandex.net/v2/issues/HOMEWORKSHRI-161/ -H "Authorization: OAuth $OAUTH_TOKEN" -H "X-Org-ID: $X_ORG_ID" -H "Content-type: application/json" -d "$TICKET_TITLE"
if [ "$?" != "0" ]; then
  echo "[ERROR] Failed post request to release ticket" >&2
  exit 1
fi
echo "[SUCCESS] End post request to release ticket"
echo "[SUCCESS] End make release ticket"
exit 0