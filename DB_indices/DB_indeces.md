# SQL. Часть 2 - Растегаев И.О.

---


### Задание 1


Запрос к учебной базе данных, который вычисляет процентное отношение общего размера всех индексов к общему размеру всех таблиц.

```
SELECT 
    ROUND(SUM(index_length) / SUM(data_length + index_length) * 100, 2) AS indexes_percentage,
    CONCAT(ROUND(SUM(index_length) / 1024 / 1024, 2), ' MB') AS total_index_size,
    CONCAT(ROUND(SUM(data_length) / 1024 / 1024, 2), ' MB') AS total_data_size,
    CONCAT(ROUND(SUM(data_length + index_length) / 1024 / 1024, 2), ' MB') AS total_size
FROM 
    information_schema.TABLES
WHERE 
    table_schema = DATABASE();

```

![ex1](images/ex1.jpg)

---

### Задание 2


```
EXPLAIN ANALYZE
select distinct concat(c.last_name, ' ', c.first_name), sum(p.amount) over (partition by c.customer_id, f.title)
from payment p, rental r, customer c, inventory i, film f
where date(p.payment_date) = '2005-07-30' and p.payment_date = r.rental_date and r.customer_id = c.customer_id and i.inventory_id = r.inventory_id

```

```
-> Table scan on <temporary>  (cost=2.5..2.5 rows=0) (actual time=56301..56309 rows=391 loops=1)
    -> Temporary table with deduplication  (cost=0..0 rows=0) (actual time=56301..56301 rows=391 loops=1)
        -> Window aggregate with buffering: sum(payment.amount) OVER (PARTITION BY c.customer_id,f.title )   (actual time=20262..51233 rows=642000 loops=1)
            -> Sort: c.customer_id, f.title  (actual time=20262..24918 rows=642000 loops=1)
                -> Stream results  (cost=104 rows=1000) (actual time=632..14886 rows=642000 loops=1)
                    -> Inner hash join (no condition)  (cost=104 rows=1000) (actual time=632..5330 rows=642000 loops=1)
                        -> Covering index scan on f using idx_title  (cost=103 rows=1000) (actual time=0.0656..8.65 rows=1000 loops=1)
                        -> Hash
                            -> Nested loop inner join  (cost=1.4 rows=1) (actual time=1.67..627 rows=642 loops=1)
                                -> Nested loop inner join  (cost=1.05 rows=1) (actual time=1.59..577 rows=642 loops=1)
                                    -> Nested loop inner join  (cost=0.7 rows=1) (actual time=1.51..532 rows=642 loops=1)
                                        -> Filter: (cast(p.payment_date as date) = '2005-07-30')  (cost=0.35 rows=1) (actual time=1.42..468 rows=634 loops=1)
                                            -> Table scan on p  (cost=0.35 rows=1) (actual time=0.0492..349 rows=16044 loops=1)
                                        -> Covering index lookup on r using rental_date (rental_date=p.payment_date)  (cost=0.35 rows=1) (actual time=0.0377..0.0664 rows=1.01 loops=634)
                                    -> Single-row index lookup on c using PRIMARY (customer_id=r.customer_id)  (cost=0.35 rows=1) (actual time=0.0282..0.035 rows=1 loops=642)
                                -> Single-row covering index lookup on i using PRIMARY (inventory_id=r.inventory_id)  (cost=0.35 rows=1) (actual time=0.0362..0.043 rows=1 loops=642)


```

Узкие места в запросе:

1) Использование DATE() в условии WHERE:

Функция DATE(p.payment_date) препятствует использованию индексов по полю payment_date

2) Неправильное соединение по дате:

Условие p.payment_date = r.rental_date некорректно - дата платежа и дата аренды обычно разные

3) Оконная функция с избыточным PARTITION BY:

PARTITION BY c.customer_id, f.title создает слишком много групп

4) Избыточные соединения таблиц:

Запрос соединяет таблицы, которые не все нужны для конечного результата

5) Использование DISTINCT с оконными функциями:

DISTINCT применяется после вычисления оконных функций, что неэффективно

Оптимизированный запрос:

```
CREATE INDEX idx_payment_date ON payment(payment_date);
CREATE INDEX idx_payment_rental_id ON payment(rental_id);
CREATE INDEX idx_rental_customer_id ON rental(customer_id);
CREATE INDEX idx_rental_inventory_id ON rental(inventory_id);
CREATE INDEX idx_inventory_film_id ON inventory(film_id);

EXPLAIN ANALYZE
SELECT 
    CONCAT(c.last_name, ' ', c.first_name) AS customer_name,
    f.title AS film_title,
    SUM(p.amount) AS total_payment
FROM payment p
JOIN rental r ON p.rental_id = r.rental_id
JOIN customer c ON r.customer_id = c.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
WHERE p.payment_date >= '2005-07-30 00:00:00' 
  AND p.payment_date < '2005-07-31 00:00:00'
GROUP BY c.customer_id, c.last_name, c.first_name, f.title;

```

```
-> Table scan on <temporary>  (actual time=685..699 rows=634 loops=1)
    -> Aggregate using temporary table  (actual time=685..685 rows=634 loops=1)
        -> Nested loop inner join  (cost=1.75 rows=1) (actual time=1.59..678 rows=634 loops=1)
            -> Nested loop inner join  (cost=1.4 rows=1) (actual time=1.5..627 rows=634 loops=1)
                -> Nested loop inner join  (cost=1.05 rows=1) (actual time=1.42..576 rows=634 loops=1)
                    -> Nested loop inner join  (cost=0.7 rows=1) (actual time=1.35..532 rows=634 loops=1)
                        -> Filter: ((p.payment_date >= TIMESTAMP'2005-07-30 00:00:00') and (p.payment_date < TIMESTAMP'2005-07-31 00:00:00') and (p.rental_id is not null))  (cost=0.35 rows=1) (actual time=1.27..481 rows=634 loops=1)
                            -> Table scan on p  (cost=0.35 rows=1) (actual time=0.0409..358 rows=16044 loops=1)
                        -> Single-row index lookup on r using PRIMARY (rental_id=p.rental_id)  (cost=0.35 rows=1) (actual time=0.0381..0.045 rows=1 loops=634)
                    -> Single-row index lookup on c using PRIMARY (customer_id=r.customer_id)  (cost=0.35 rows=1) (actual time=0.0284..0.0352 rows=1 loops=634)
                -> Single-row index lookup on i using PRIMARY (inventory_id=r.inventory_id)  (cost=0.35 rows=1) (actual time=0.0375..0.0442 rows=1 loops=634)
            -> Single-row index lookup on f using PRIMARY (film_id=i.film_id)  (cost=0.35 rows=1) (actual time=0.0374..0.0445 rows=1 loops=634)

```

---

### Задание 3


1) GIN (Generalized Inverted Index)
Оптимизация поиска по составным значениям (массивы, JSON, полнотекстовый поиск)
2) GiST (Generalized Search Tree)
Геоданные, полнотекстовый поиск, IP-адреса, нечеткий поиск
3) SP-GiST (Space-Partitioned GiST)
Разделяемые структуры данных (тетрис-подобное разбиение пространства)
4) BRIN (Block Range INdex)
Очень большие таблицы с коррелированными данными (например, временные ряды)
5) Bloom Filter Index
Эффективный поиск по множеству столбцов (каждый индекс покрывает все столбцы)
6) Hash Index с crash-безопасностью
Журналируются (WAL-logged), устойчивы к сбоям
Поддерживаются в репликации


