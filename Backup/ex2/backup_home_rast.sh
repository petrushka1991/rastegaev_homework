#!/bin/bash

#Каталог для бекапа
BACKUP_DIR="/tmp/backup"

#Источник
SOURCE_DIR="/home/rast"

#Лог
LOG_FILE="/var/log/backup_home_rast.log"

#Команда
echo "Начало резервного копирования: $(date)" >> "$LOG_FILE"
rsync -av --delete --exclude='.*' "$SOURCE_DIR/" "$BACKUP_DIR/" >> "$LOG_FILE" 2>&1

#Статус
if [ $? -eq 0 ]; then
    echo "Резервное копирование успешно завершено: $(date)" >> "$LOG_FILE"
    logger "Резервное копирование домашней директории успешно завершено."
else
    echo "Ошибка при резервном копировании: $(date)" >> "$LOG_FILE"
    logger "Ошибка при резервном копировании домашней директории."
fi



