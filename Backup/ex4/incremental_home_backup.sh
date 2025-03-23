#!/bin/bash

# Параметры
USER_HOME="$HOME"  # Домашняя директория пользователя
REMOTE_USER="rast"  # Пользователь на удалённом сервере
REMOTE_HOST="192.168.0.2"  # IP-адрес удалённого сервера
REMOTE_BACKUP_DIR="/home/rast/destination_backup"  # Директория на удалённом сервере
MAX_BACKUPS=5  # Максимальное количество резервных копий

# Генерируем имя для новой резервной копии
BACKUP_NAME="backup_$(date +%Y%m%d_%H%M%S)"
REMOTE_BACKUP_PATH="$REMOTE_BACKUP_DIR/$BACKUP_NAME"

# Выполняем резервное копирование на удалённый сервер с помощью rsync
rsync -av --delete "$USER_HOME/" "$REMOTE_USER@$REMOTE_HOST:$REMOTE_BACKUP_PATH/"

# Удаляем старые резервные копии на удалённом сервере (оставляем только последние MAX_BACKUPS)
ssh "$REMOTE_USER@$REMOTE_HOST" "
  BACKUP_LIST=(\$(ls -dt "$REMOTE_BACKUP_DIR"/backup_*))
  BACKUP_COUNT=\${#BACKUP_LIST[@]}

  if [ \"\$BACKUP_COUNT\" -gt \"$MAX_BACKUPS\" ]; then
    for ((i=$MAX_BACKUPS; i<\$BACKUP_COUNT; i++)); do
      rm -rf \"\${BACKUP_LIST[\$i]}\"
    done
  fi
"

echo "Резервное копирование завершено: $BACKUP_NAME"
