# Домашнее задание к занятию 3 «Резервное копирование» - `Растегаев И.О.`

---


### Задание 1


Создание резервной копии домашней директории с использованием rsync.

![rsync_checksum](https://github.com/petrushka1991/rastegaev_homework/blob/main/Backup/images/rsync_checksum.jpg)


---

### Задание 2


Выполненное резервное копирование домашней директории пользователя скриптом по расписанию.
Содержимое лога, содержимое бекапа, статус cron.

![rsync_cron](https://github.com/petrushka1991/rastegaev_homework/blob/main/Backup/images/rsync_cron.jpg)

[bash скрипт](ex2/backup_home_rast.sh)

[crontab файл](ex2/crontab)


---

### Задание 3


Команда:

```
rsync -av --bwlimit=1000 --progress /home/rast/source_backup/alpine rast@192.168.0.2:/home/rast/destination_backup/

```

![large_file_limit](https://github.com/petrushka1991/rastegaev_homework/blob/main/Backup/images/large_file_limit.jpg)


---

### Задание 4


Результат выполнения скрипта резервного копирования.

![incremental_backup](https://github.com/petrushka1991/rastegaev_homework/blob/main/Backup/images/incremental_backup.jpg)


Результат выполнения скрипта восстановления их резевоной копии.

![incremental_restore](https://github.com/petrushka1991/rastegaev_homework/blob/main/Backup/images/incremental_restore.jpg)


[Скрипт резервного копировния](ex4/incremental_home_backup.sh)

[Скрипт восстановления](ex4/incremental_home_restore.sh)
