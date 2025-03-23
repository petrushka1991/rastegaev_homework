# Домашнее задание к занятию "`Домашнее задание к занятию 2 «Кластеризация и балансировка нагрузки»`" - `Растегаев И.О.`

---


### Задание 1


Вывод curl на порт 1325, запросы идут 50 на 50.

![balancing_tcp](https://github.com/petrushka1991/rastegaev_homework/blob/main/Clustering_and_load_balancing/images/balancing_tcp.jpg)


---

### Задание 2


Вывод curl с указанием домена, запросы вроде \~40%\~30%\~20%.

![blancing_http](https://github.com/petrushka1991/rastegaev_homework/blob/main/images/clustering_and_load_balancing/balancing_http.jpg)

Скриншот страницы stats.

![blancing_http](https://github.com/petrushka1991/rastegaev_homework/blob/main/images/clustering_and_load_balancing/haproxy_stats.jpg) 

Вывод curl без указания домена, не вкурил этот момент.

![blancing_http](https://github.com/petrushka1991/rastegaev_homework/blob/main/images/clustering_and_load_balancing/without_http.jpg)


---

### Задание 3


Запрос .jpg файлов с веб-сервера.

![nginx_jpg](https://github.com/petrushka1991/rastegaev_homework/blob/main/images/clustering_and_load_balancing/nginx_jpg.jpg) 

Запрос не .jpg c веб-сервера.

![balancing_any_other_file](https://github.com/petrushka1991/rastegaev_homework/blob/main/images/clustering_and_load_balancing/balancing_any_other_file.jpg)


### Задание 4


Запрос curl к домену example1.local

![balancing_group1](https://github.com/petrushka1991/rastegaev_homework/blob/main/images/clustering_and_load_balancing/balancing_group1.jpg)

Запрос curl к домену example2.local

![balancing_group2](https://github.com/petrushka1991/rastegaev_homework/blob/main/images/clustering_and_load_balancing/balancing_group2.jpg)

