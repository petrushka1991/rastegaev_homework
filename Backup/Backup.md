#  - ``

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
rsync -av --bwlimit=1000 --progress /home/rast/source_backup/alpine rast@192.168.0.2:/home/rast/destination_backup/

![large_file_limit](https://github.com/petrushka1991/rastegaev_homework/blob/main/Backup/images/large_file_limit.jpg)


---

### Задание 4


text.

![]()

[]()
