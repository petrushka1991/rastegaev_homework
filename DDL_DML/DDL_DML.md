# Домашнее задание к занятию «Работа с данными (DDL/DML)» - Растегаев И.О.

---


### Задание 1


1. Создание учетной записи sys_temp и получение списка пользователей в БД.

![create_user](images/create_user.jpg)

2. Делегирование всех прав пользователю sys_temp и запрос на получение прав пользователя.

![grants_all_show_grants](images/grants_all_show_grants.jpg)

3. Восстановление дампа БД и show tables.

![show_tables](images/show_tables.jpg)

Диаграмма из DBeaver.

![dbeaver_db_diagram](images/dbeaver_db_diagram.jpg)


---

### Задание 2


Таблица с ключами.

| Название таблицы  | Название первичного ключа |
| ------------- | ------------------------------|
| actor         | actor_id                      |
| address       | address_id                    |
| category      | category_id                   |
| city          | city_id                       |
| country       | country_id                    |
| custumer      | custumer_id                   |
| film          | film_id                       |
| film_actor    | film_id, actor_id             |
| film_category | film_id, category_id          |
| film_text     | film_id                       |
| intentory     | intentory_id                  |
| language      | language_id                   |
| payment       | payment_id                    |
| rental        | rental_id                     |
| staff         | staff_id                      |
| store         | store_id                      |
| actor_info    | actor_id                      |
| customer_list | ID                            |
| film_list     | FID                           |
| nicer_but_slower_film_list    | FID           |
| sales_by_store| -                             |
| staff_list    | ID                            |


---

### Задание 3


Отзываем права на внесение, изменение и удаление у sys_temp в базе sakila.

![revoke_from_user](images/revoke_from_user.jpg)


