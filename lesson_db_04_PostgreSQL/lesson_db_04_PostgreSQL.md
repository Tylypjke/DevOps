## Задача 1

Используя Docker, поднимите инстанс PostgreSQL (версию 13). Данные БД сохраните в volume.

Подключитесь к БД PostgreSQL, используя `psql`.

Воспользуйтесь командой `\?` для вывода подсказки по имеющимся в `psql` управляющим командам.

**Найдите и приведите** управляющие команды для:

- вывода списка БД,
- подключения к БД,
- вывода списка таблиц,
- вывода описания содержимого таблиц,
- выхода из psql.

## Решение

mkdir docker_PostgreSQL

cd docker_PostgreSQL/

nano docker-compose.yml

```
version: '3.9'
services:
  postgres:
    image: postgres:13.3
    container_name: psql
    ports:
      - "5432:5432"
    environment:
      POSTGRES_USER: "adminpostgre"
      POSTGRES_PASSWORD: "123456789"
      POSTGRES_DB: "testpostgre"
      PGDATA: "/var/lib/postgresql/data/pgdata"
    restart: always
    volumes:
      - ../2. Init Database:/docker-entrypoint-initdb.d
      - .:/var/lib/postgresql/data
```

sudo docker-compose up -d

sudo docker ps -a

sudo docker exec -it psql bash 

psql -U adminpostgre -d testpostgre


- вывода списка БД
```
testpostgre=# \l
                                        List of databases
    Name     |    Owner     | Encoding |  Collate   |   Ctype    |       Access privileges
-------------+--------------+----------+------------+------------+-------------------------------
 postgres    | adminpostgre | UTF8     | en_US.utf8 | en_US.utf8 |
 template0   | adminpostgre | UTF8     | en_US.utf8 | en_US.utf8 | =c/adminpostgre              +
             |              |          |            |            | adminpostgre=CTc/adminpostgre
 template1   | adminpostgre | UTF8     | en_US.utf8 | en_US.utf8 | =c/adminpostgre              +
             |              |          |            |            | adminpostgre=CTc/adminpostgre
 testpostgre | adminpostgre | UTF8     | en_US.utf8 | en_US.utf8 |
(4 rows)
```


- подключения к БД
```
testpostgre=# \c postgres
You are now connected to database "postgres" as user "adminpostgre"
```

- вывода списка таблиц
```
postgres=# \dtS
                      List of relations
   Schema   |          Name           | Type  |    Owner
------------+-------------------------+-------+--------------
 pg_catalog | pg_aggregate            | table | adminpostgre
 pg_catalog | pg_am                   | table | adminpostgre
 pg_catalog | pg_amop                 | table | adminpostgre
 pg_catalog | pg_amproc               | table | adminpostgre
 pg_catalog | pg_attrdef              | table | adminpostgre
 pg_catalog | pg_attribute            | table | adminpostgre
 pg_catalog | pg_auth_members         | table | adminpostgre
 pg_catalog | pg_authid               | table | adminpostgre
 pg_catalog | pg_cast                 | table | adminpostgre
 pg_catalog | pg_class                | table | adminpostgre
 pg_catalog | pg_collation            | table | adminpostgre
 pg_catalog | pg_constraint           | table | adminpostgre
 pg_catalog | pg_conversion           | table | adminpostgre
 pg_catalog | pg_database             | table | adminpostgre
 pg_catalog | pg_db_role_setting      | table | adminpostgre
 pg_catalog | pg_default_acl          | table | adminpostgre
 pg_catalog | pg_depend               | table | adminpostgre
 pg_catalog | pg_description          | table | adminpostgre
 pg_catalog | pg_enum                 | table | adminpostgre
 pg_catalog | pg_event_trigger        | table | adminpostgre
 pg_catalog | pg_extension            | table | adminpostgre
 pg_catalog | pg_foreign_data_wrapper | table | adminpostgre
 pg_catalog | pg_foreign_server       | table | adminpostgre
 pg_catalog | pg_foreign_table        | table | adminpostgre
 pg_catalog | pg_index                | table | adminpostgre
 pg_catalog | pg_inherits             | table | adminpostgre
 pg_catalog | pg_init_privs           | table | adminpostgre
 pg_catalog | pg_language             | table | adminpostgre
 pg_catalog | pg_largeobject          | table | adminpostgre
 pg_catalog | pg_largeobject_metadata | table | adminpostgre
 pg_catalog | pg_namespace            | table | adminpostgre
 pg_catalog | pg_opclass              | table | adminpostgre
 pg_catalog | pg_operator             | table | adminpostgre
 pg_catalog | pg_opfamily             | table | adminpostgre
 pg_catalog | pg_partitioned_table    | table | adminpostgre
 pg_catalog | pg_policy               | table | adminpostgre
 pg_catalog | pg_proc                 | table | adminpostgre
 pg_catalog | pg_publication          | table | adminpostgre
 pg_catalog | pg_publication_rel      | table | adminpostgre
 pg_catalog | pg_range                | table | adminpostgre
 pg_catalog | pg_replication_origin   | table | adminpostgre
 pg_catalog | pg_rewrite              | table | adminpostgre
 pg_catalog | pg_seclabel             | table | adminpostgre
 pg_catalog | pg_sequence             | table | adminpostgre
 pg_catalog | pg_shdepend             | table | adminpostgre
 pg_catalog | pg_shdescription        | table | adminpostgre
 pg_catalog | pg_shseclabel           | table | adminpostgre
 pg_catalog | pg_statistic            | table | adminpostgre
 pg_catalog | pg_statistic_ext        | table | adminpostgre
 pg_catalog | pg_statistic_ext_data   | table | adminpostgre
 pg_catalog | pg_subscription         | table | adminpostgre
 pg_catalog | pg_subscription_rel     | table | adminpostgre
 pg_catalog | pg_tablespace           | table | adminpostgre
 pg_catalog | pg_transform            | table | adminpostgre
 pg_catalog | pg_trigger              | table | adminpostgre
 pg_catalog | pg_ts_config            | table | adminpostgre
 pg_catalog | pg_ts_config_map        | table | adminpostgre
 pg_catalog | pg_ts_dict              | table | adminpostgre
 pg_catalog | pg_ts_parser            | table | adminpostgre
 pg_catalog | pg_ts_template          | table | adminpostgre
 pg_catalog | pg_type                 | table | adminpostgre
 pg_catalog | pg_user_mapping         | table | adminpostgre
(62 rows)
```

- вывода описания содержимого таблиц
```
postgres=# \dS+ pg_am
                                  Table "pg_catalog.pg_am"
  Column   |  Type   | Collation | Nullable | Default | Storage | Stats target | Description
-----------+---------+-----------+----------+---------+---------+--------------+-------------
 oid       | oid     |           | not null |         | plain   |              |
 amname    | name    |           | not null |         | plain   |              |
 amhandler | regproc |           | not null |         | plain   |              |
 amtype    | "char"  |           | not null |         | plain   |              |
Indexes:
    "pg_am_name_index" UNIQUE, btree (amname)
    "pg_am_oid_index" UNIQUE, btree (oid)
Access method: heap
```

- выход из psql

```
postgres=# \q
```


## Задача 2

Используя `psql`, создайте БД `test_database`.

Изучите [бэкап БД](https://github.com/netology-code/virt-homeworks/tree/virt-11/06-db-04-postgresql/test_data).

Восстановите бэкап БД в `test_database`.

Перейдите в управляющую консоль `psql` внутри контейнера.

Подключитесь к восстановленной БД и проведите операцию ANALYZE для сбора статистики по таблице.

Используя таблицу [pg_stats](https://postgrespro.ru/docs/postgresql/12/view-pg-stats), найдите столбец таблицы `orders` 
с наибольшим средним значением размера элементов в байтах.

**Приведите в ответе** команду, которую вы использовали для вычисления, и полученный результат.

## Решение

```
postgres=# CREATE DATABASE test_database;
CREATE DATABASE
postgres=# \l
                                         List of databases
     Name      |    Owner     | Encoding |  Collate   |   Ctype    |       Access privileges
---------------+--------------+----------+------------+------------+-------------------------------
 postgres      | adminpostgre | UTF8     | en_US.utf8 | en_US.utf8 |
 template0     | adminpostgre | UTF8     | en_US.utf8 | en_US.utf8 | =c/adminpostgre              +
               |              |          |            |            | adminpostgre=CTc/adminpostgre
 template1     | adminpostgre | UTF8     | en_US.utf8 | en_US.utf8 | =c/adminpostgre              +
               |              |          |            |            | adminpostgre=CTc/adminpostgre
 test_database | adminpostgre | UTF8     | en_US.utf8 | en_US.utf8 |
 testpostgre   | adminpostgre | UTF8     | en_US.utf8 | en_US.utf8 |
(5 rows)
```

копируем бэкап БД в контейнер 

выходим с контйнера
```
sudo docker cp /home/alev/docker_PostgreSQL/test_dump.sql db5e3a4789ab:/var/tmp/test_dump.sql
```

sudo docker exec -it psql bash

восстановим бэкап

```
root@db5e3a4789ab:/# psql -U adminpostgre -d test_database < /var/tmp/test_dump.sql
SET
SET
SET
SET
SET
 set_config
------------

(1 row)

SET
SET
SET
SET
SET
SET
CREATE TABLE
ERROR:  role "postgres" does not exist
CREATE SEQUENCE
ERROR:  role "postgres" does not exist
ALTER SEQUENCE
ALTER TABLE
COPY 8
 setval
--------
      8
(1 row)

ALTER TABLE
```

Подключитесь к восстановленной БД и проведите операцию ANALYZE для сбора статистики по таблице.

```
root@db5e3a4789ab:/# psql -U adminpostgre -d test_database
psql (13.3 (Debian 13.3-1.pgdg100+1))
Type "help" for help.

test_database=# \dt
           List of relations
 Schema |  Name  | Type  |    Owner
--------+--------+-------+--------------
 public | orders | table | adminpostgre
(1 row)

test_database=# ANALYZE verbose orders;
INFO:  analyzing "public.orders"
INFO:  "orders": scanned 1 of 1 pages, containing 8 live rows and 0 dead rows; 8 rows in sample, 8 estimated total rows
ANALYZE
```

Используя таблицу [pg_stats](https://postgrespro.ru/docs/postgresql/12/view-pg-stats), найдите столбец таблицы `orders` 
с наибольшим средним значением размера элементов в байтах.

```
test_database=# ANALYZE verbose orders;
INFO:  analyzing "public.orders"
INFO:  "orders": scanned 1 of 1 pages, containing 8 live rows and 0 dead rows; 8 rows in sample, 8 estimated total rows
ANALYZE
test_database=# select attname, avg_width from pg_stats where tablename='orders';
 attname | avg_width
---------+-----------
 id      |         4
 title   |        16
 price   |         4
(3 rows)
```

## Задача 3

Архитектор и администратор БД выяснили, что ваша таблица orders разрослась до невиданных размеров и
поиск по ней занимает долгое время. Вам как успешному выпускнику курсов DevOps в Нетологии предложили
провести разбиение таблицы на 2: шардировать на orders_1 - price>499 и orders_2 - price<=499.

Предложите SQL-транзакцию для проведения этой операции.

Можно ли было изначально исключить ручное разбиение при проектировании таблицы orders?


## Решение

```
BEGIN;
CREATE TABLE orders_1 (LIKE orders);
INSERT INTO orders_1 SELECT * FROM orders WHERE price >499;
DELETE FROM orders WHERE price >499;
CREATE TABLE orders_2 (LIKE orders);
INSERT INTO orders_2 SELECT * FROM orders WHERE price <=499;
DELETE FROM orders WHERE price <=499;
COMMIT;
```

```
test_database=# SELECT * FROM public.orders;
 id | title | price
----+-------+-------
(0 rows)

test_database=# SELECT * FROM public.orders_1;
 id |       title        | price
----+--------------------+-------
  2 | My little database |   500
  6 | WAL never lies     |   900
  8 | Dbiezdmin          |   501
(3 rows)

test_database=# SELECT * FROM public.orders_2;
 id |        title         | price
----+----------------------+-------
  1 | War and peace        |   100
  3 | Adventure psql time  |   300
  4 | Server gravity falls |   300
  5 | Log gossips          |   123
  7 | Me and my bash-pet   |   499
(5 rows)
```

Можно ли было изначально исключить ручное разбиение при проектировании таблицы orders?

Да, если использовать декларативное секционирование

https://postgrespro.ru/docs/postgresql/10/ddl-partitioning


## Задача 4

Используя утилиту `pg_dump`, создайте бекап БД `test_database`.

Как бы вы доработали бэкап-файл, чтобы добавить уникальность значения столбца `title` для таблиц `test_database`?


## Решение

pg_dump -U adminpostgre -d test_database > /var/tmp/backup_database_dump.sql

cat /etc/my.cnf - исходник 

Добавляем уникальное значение столбца `title` для таблицы `test_database`

```
test_database=# CREATE unique INDEX title_un ON public.orders(title);
CREATE INDEX
```

