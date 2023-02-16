## Задача 1

Используя docker поднимите инстанс PostgreSQL (версию 12) c 2 volume, в который будут складываться данные БД и бэкапы.

Приведите получившуюся команду или docker-compose манифест.

## Решение

user@vm1:~$ mkdir docker_postgresql

user@vm1:~$ cd docker_postgresql/

nano docker-compose.yml

```
version: '3.8'

volumes:
  data: {}
  backup: {}

services:

  postgres:
    image: postgres:12
    container_name: psql
    ports:
      - "0.0.0.0:5432:5432"
    volumes:
      - data:/var/lib/postgresql/data
      - backup:/media/postgresql/backup
    environment:
      POSTGRES_USER: "adminpostgre"
      POSTGRES_PASSWORD: "123456789"
      POSTGRES_DB: "testpostgre"
    restart: always
```

sudo docker-compose up -d

sudo docker exec -it psql bash (провалился в контейнер)

## Задача 2

В БД из задачи 1: 
- создайте пользователя test-admin-user и БД test_db
- в БД test_db создайте таблицу orders и clients (спeцификация таблиц ниже)
- предоставьте привилегии на все операции пользователю test-admin-user на таблицы БД test_db
- создайте пользователя test-simple-user  
- предоставьте пользователю test-simple-user права на SELECT/INSERT/UPDATE/DELETE данных таблиц БД test_db

Таблица orders:
- id (serial primary key)
- наименование (string)
- цена (integer)

Таблица clients:
- id (serial primary key)
- фамилия (string)
- страна проживания (string, index)
- заказ (foreign key orders)

Приведите:
- итоговый список БД после выполнения пунктов выше,
- описание таблиц (describe)
- SQL-запрос для выдачи списка пользователей с правами над таблицами test_db
- список пользователей с правами над таблицами test_db

## Решение

psql -U adminpostgre -d testpostgre

\l+

выйти из psql

createdb test_db -U adminpostgre

psql -d test_db -U adminpostgre

CREATE USER test_admin_user;

```
CREATE TABLE orders (
    id SERIAL,
    наименование VARCHAR, 
    цена INTEGER,
    PRIMARY KEY (id)
);
```

```
CREATE TABLE clients (
    id SERIAL,
    фамилия VARCHAR,
    "страна проживания" VARCHAR, 
    заказ INTEGER,
    PRIMARY KEY (id),
    CONSTRAINT fk_заказ
      FOREIGN KEY(заказ) 
	    REFERENCES orders(id)
);
```

CREATE INDEX ON clients("страна проживания");

GRANT ALL ON TABLE orders TO test_admin_user;

GRANT ALL ON TABLE clients TO test_admin_user;

CREATE USER test_simple_user;

GRANT SELECT,INSERT,UPDATE,DELETE ON TABLE orders TO test_simple_user;

GRANT SELECT,INSERT,UPDATE,DELETE ON TABLE clients TO test_simple_user;

SQL-запрос для выдачи списка пользователей с правами над таблицами test_db:

SELECT grantee, table_catalog, table_name, privilege_type FROM information_schema.table_privileges WHERE table_name IN ('orders','clients');

список пользователей с правами над таблицами test_db:

![image](https://github.com/Tylypjke/DevOps/blob/bbb1708344f5e279d140f467999c852cb882bd65/lesson_db_02/spisok.jpg)

описание таблиц (describe):

![image](https://github.com/Tylypjke/DevOps/blob/bbb1708344f5e279d140f467999c852cb882bd65/lesson_db_02/ops.jpg)

итоговый список БД после выполнения пунктов выше:

![image](https://github.com/Tylypjke/DevOps/blob/bbb1708344f5e279d140f467999c852cb882bd65/lesson_db_02/spisoktabl.jpg)

## Задача 3

Используя SQL синтаксис - наполните таблицы следующими тестовыми данными:

Таблица orders

|Наименование|цена|
|------------|----|
|Шоколад| 10 |
|Принтер| 3000 |
|Книга| 500 |
|Монитор| 7000|
|Гитара| 4000|

Таблица clients

|ФИО|Страна проживания|
|------------|----|
|Иванов Иван Иванович| USA |
|Петров Петр Петрович| Canada |
|Иоганн Себастьян Бах| Japan |
|Ронни Джеймс Дио| Russia|
|Ritchie Blackmore| Russia|

Используя SQL синтаксис:
- вычислите количество записей для каждой таблицы 
- приведите в ответе:
    - запросы 
    - результаты их выполнения.

## Решение

INSERT INTO orders VALUES (1, 'Шоколад', 10), (2, 'Принтер', 3000), (3, 'Книга', 500), (4, 'Монитор', 7000), (5, 'Гитара', 4000);

INSERT INTO clients VALUES (1, 'Иванов Иван Иванович', 'USA'), (2, 'Петров Петр Петрович', 'Canada'), (3, 'Иоганн Себастьян Бах', 'Japan'), (4, 'Ронни Джеймс Дио', 'Russia'), (5, 'Ritchie Blackmore', 'Russia');

SELECT COUNT (*) FROM orders;

SELECT COUNT (*) FROM clients;

![image](https://github.com/Tylypjke/DevOps/blob/bbb1708344f5e279d140f467999c852cb882bd65/lesson_db_02/result.jpg)

## Задача 4

Часть пользователей из таблицы clients решили оформить заказы из таблицы orders.

Используя foreign keys свяжите записи из таблиц, согласно таблице:

|ФИО|Заказ|
|------------|----|
|Иванов Иван Иванович| Книга |
|Петров Петр Петрович| Монитор |
|Иоганн Себастьян Бах| Гитара |

Приведите SQL-запросы для выполнения данных операций.

Приведите SQL-запрос для выдачи всех пользователей, которые совершили заказ, а также вывод данного запроса.
 
Подсказка - используйте директиву `UPDATE`.

## Решение

UPDATE clients SET заказ=(select id from orders where наименование='Книга') WHERE фамилия='Иванов Иван Иванович';

UPDATE clients SET заказ=(select id from orders where наименование='Монитор') WHERE фамилия='Петров Петр Петрович';

UPDATE clients SET заказ=(select id from orders where наименование='Гитара') WHERE фамилия='Иоганн Себастьян Бах';

SELECT* FROM clients WHERE заказ IS NOT NULL;

![image](https://github.com/Tylypjke/DevOps/blob/bbb1708344f5e279d140f467999c852cb882bd65/lesson_db_02/4.jpg)

## Задача 5

Получите полную информацию по выполнению запроса выдачи всех пользователей из задачи 4 (используя директиву EXPLAIN).

Приведите получившийся результат и объясните что значат полученные значения.

## Решение

EXPLAIN SELECT * FROM clients WHERE заказ IS NOT NULL;

![image](https://github.com/Tylypjke/DevOps/blob/bbb1708344f5e279d140f467999c852cb882bd65/lesson_db_02/5.jpg)

Сканирование таблицы clients методом Seq Scan (последовательного чтения данных)

cost=0.00..18.10 - 0.00 ожидаемые затраты на получение первой строки, 18.10 ожидаемые затраты на получение всех строк

rows=806 - ожидаемое число строк

width=72 - ожидаемый средний размер строк (в байтах) 

Каждая строка сравнивается с условием "заказ" не = 0.

## Задача 6

Создайте бэкап БД test_db и поместите его в volume, предназначенный для бэкапов (см. Задачу 1).

Остановите контейнер с PostgreSQL (но не удаляйте volumes).

Поднимите новый пустой контейнер с PostgreSQL.

Восстановите БД test_db в новом контейнере.

Приведите список операций, который вы применяли для бэкапа данных и восстановления. 

## Решение

pg_dump -U adminpostgre test_db > /media/postgresql/backup/psbackup1.backup

ls -lah /media/postgresql/backup/

exit

sudo docker-compose stop

sudo docker ps -a

sudo docker run --name pg12_new -e POSTGRES_PASSWORD=123456789 -d postgres:12

sudo docker ps -a

sudo docker exec -it pg12_new bash

exit

user@vm1:~/docker_postgresql$ mkdir backup

sudo docker cp psql:/media/postgresql/backup/psbackup1.backup backup/ 

ls -lah backup/

sudo docker cp backup/psbackup1.backup pg12_new:/home/

sudo docker exec -it pg12_new bash

ls -lah /home/

psql -U postgres -d test_db -f /home/psbackup1.backup

```
psql: error: connection to server on socket "/var/run/postgresql/.s.PGSQL.5432" failed: FATAL:  database "test_db" does not exist
```

createdb test_db -U postgres

psql -U postgres

\l+

exit

psql -U postgres -d test_db -f /home/psbackup1.backup

```
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
psql:/home/psbackup1.backup:35: ERROR:  role "adminpostgre" does not exist
CREATE SEQUENCE
psql:/home/psbackup1.backup:50: ERROR:  role "adminpostgre" does not exist
ALTER SEQUENCE
CREATE TABLE
psql:/home/psbackup1.backup:70: ERROR:  role "adminpostgre" does not exist
CREATE SEQUENCE
psql:/home/psbackup1.backup:85: ERROR:  role "adminpostgre" does not exist
ALTER SEQUENCE
ALTER TABLE
ALTER TABLE
COPY 5
COPY 5
 setval
--------
      1
(1 row)

 setval
--------
      1
(1 row)

ALTER TABLE
ALTER TABLE
CREATE INDEX
ALTER TABLE
psql:/home/psbackup1.backup:183: ERROR:  role "test_admin_user" does not exist
psql:/home/psbackup1.backup:184: ERROR:  role "test_simple_user" does not exist
psql:/home/psbackup1.backup:191: ERROR:  role "test_admin_user" does not exist
psql:/home/psbackup1.backup:192: ERROR:  role "test_simple_user" does not exist
```





