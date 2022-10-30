#!/usr/bin/env bash

PROJECT_NAME="infra_hw"

# собираем докер образ
echo "[INFO] Start build docker"
docker build -t $PROJECT_NAME .

if [ "$?" != "0" ]; then
  echo "[ERROR] Failed build docker" >&2
  exit 1
fi

echo "[SUCCESS] End build docker"

# собираем проект для production
echo "[INFO] Start run docker"
docker run --rm -v "$PWD/build:/app/build" --name $PROJECT_NAME'_prod' $PROJECT_NAME

if [ "$?" != "0" ]; then
  echo "[ERROR] Failed run docker" >&2
  exit 1
fi
echo "[SUCCESS] End run docker"

# записываем информацию о собранном образе в релизный тикет
echo "[INFO] Start post request to release ticket"
COMMENT_TEXT='{"text": "Собран образ с тегом '$CURRENT_TAG'"}'
curl -X POST https://api.tracker.yandex.net/v2/issues/HOMEWORKSHRI-161/comments -H "Authorization: OAuth $OAUTH_TOKEN" -H "X-Org-ID: $X_ORG_ID" -H "Content-type: application/json" -d "$COMMENT_TEXT"

if [ "$?" != "0" ]; then
  echo "[ERROR] Failed post request to release ticket" >&2
  exit 1
fi
echo "[SUCCESS] End post request to release ticket"
exit 0
