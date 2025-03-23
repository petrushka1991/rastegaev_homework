#!/bin/bash

# Параметры
REMOTE_USER="rast"  # Пользователь на удалённом сервере
REMOTE_HOST="192.168.0.2"  # IP-адрес удалённого сервера
REMOTE_BACKUP_DIR="/home/rast/destination_backup"  # Директория на удалённом сервере

# Получаем список резервных копий на удалённом сервере
BACKUP_LIST=($(ssh "$REMOTE_USER@$REMOTE_HOST" "ls -dt $REMOTE_BACKUP_DIR/backup_*"))

# Проверяем, есть ли резервные копии
if [ ${#BACKUP_LIST[@]} -eq 0 ]; then
  echo "Резервные копии не найдены."
  exit 1
fi

# Выводим список резервных копий
echo "Доступные резервные копии:"
for i in "${!BACKUP_LIST[@]}"; do
  echo "$((i+1)). ${BACKUP_LIST[$i]##*/}"
done

# Запрашиваем выбор пользователя
read -p "Выберите резервную копию для восстановления (1-${#BACKUP_LIST[@]}): " CHOICE

# Проверяем корректность выбора
if [[ ! "$CHOICE" =~ ^[0-9]+$ ]] || [ "$CHOICE" -lt 1 ] || [ "$CHOICE" -gt "${#BACKUP_LIST[@]}" ]; then
  echo "Неверный выбор."
  exit 1
fi

# Выбранная резервная копия
SELECTED_BACKUP="${BACKUP_LIST[$((CHOICE-1))]}"

# Восстанавливаем данные из резервной копии
rsync -av --delete "$REMOTE_USER@$REMOTE_HOST:$SELECTED_BACKUP/" "$HOME/"

echo "Данные восстановлены из резервной копии: ${SELECTED_BACKUP##*/}"
