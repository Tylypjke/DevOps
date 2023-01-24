## Задача 1

Подключитесь к публичному маршрутизатору в интернет. Найдите маршрут к вашему публичному IP

```
telnet route-views.routeviews.org
Username: rviews
show ip route x.x.x.x/32
show bgp x.x.x.x/32
```

## Решение

Скриншот 1

![image](https://github.com/Tylypjke/DevOps/blob/a4094fba800e104c1060178e1f62f14e69031824/lesson_network_3/1.JPG)

## Задача 2

Создайте dummy0 интерфейс в Ubuntu. Добавьте несколько статических маршрутов. Проверьте таблицу маршрутизации.

## Решение

sudo modprobe -v dummy numdummies=2

ifconfig -a | grep dummy

sudo ip addr add 20.0.0.20/24 dev dummy0

sudo ip addr add 30.0.0.30/24 dev dummy1

sudo ip link set dummy0 up

sudo ip link set dummy1 up

sudo ip ro add 20.0.0.0/24 via 20.0.0.20

sudo ip ro add 30.0.0.0/24 via 30.0.0.30

Скриншот 2

![image](https://github.com/Tylypjke/DevOps/blob/a4094fba800e104c1060178e1f62f14e69031824/lesson_network_3/2.JPG)

## Задача 3

Проверьте открытые TCP порты в Ubuntu, какие протоколы и приложения используют эти порты?  
Приведите несколько примеров.

## Решение

sudo ss -tnlp

```
53-ий порт для DNS
22-ой порт для SSH
```

Скриншот 3

![image](https://github.com/Tylypjke/DevOps/blob/a4094fba800e104c1060178e1f62f14e69031824/lesson_network_3/3.JPG)

## Задача 4

Проверьте используемые UDP сокеты в Ubuntu, какие протоколы и приложения используют эти порты?

## Решение

sudo ss -unap

```
53-ий порт для DNS
68-ой порт для DHCP 
```

Скриншот 4

![image](https://github.com/Tylypjke/DevOps/blob/a4094fba800e104c1060178e1f62f14e69031824/lesson_network_3/4.JPG)

## Задача 5

Используя diagrams.net, создайте L3 диаграмму вашей домашней сети или любой другой сети, с которой вы работали.

## Решение

Скриншот 5 

![image](https://github.com/Tylypjke/DevOps/blob/a4094fba800e104c1060178e1f62f14e69031824/lesson_network_3/5.JPG)