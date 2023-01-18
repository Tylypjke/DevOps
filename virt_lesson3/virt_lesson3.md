## Задача 1
Сценарий выполения задачи:
- создайте свой репозиторий на https://hub.docker.com;
- выберете любой образ, который содержит веб-сервер Nginx;
- создайте свой fork образа;
- реализуйте функциональность:
запуск веб-сервера в фоне с индекс-страницей, содержащей HTML-код ниже:
```
<html>
<head>
Hey, Netology
</head>
<body>
<h1>I’m DevOps Engineer!</h1>
</body>
</html>
```
Опубликуйте созданный форк в своем репозитории и предоставьте ответ в виде ссылки на   
https://hub.docker.com/username_repo.

## Решение

apt install curl

curl -fsSL get.docker.com -o get-docker.sh

chmod +x get-docker.sh

./get-docker.sh

sudo docker pull nginx

создал Dockerfile

sudo docker build -t tylypjke/nginx:v1 .

sudo docker login

sudo docker push tylypjke/nginx:v1

ссылка на образ 

https://hub.docker.com/layers/tylypjke/nginx/v1/images/sha256-6bf4f67ab8f99d971274872ff36a6caaea331f9041df900923682e591c15aa54?context=repo

sudo docker images

sudo docker run -d -p 8080:80 tylypjke/nginx:v1

Скриншот 1

## Задача 2  
Посмотрите на сценарий ниже и ответьте на вопрос:  
"Подходит ли в этом сценарии использование Docker контейнеров или лучше подойдет виртуальная машина, физическая машина? Может быть возможны разные варианты?"  

Детально опишите и обоснуйте свой выбор.

Сценарий:
- Высоконагруженное монолитное java веб-приложение;
- Nodejs веб-приложение;
- Мобильное приложение c версиями для Android и iOS;
- Шина данных на базе Apache Kafka;
- Elasticsearch кластер для реализации логирования продуктивного веб-приложения - три ноды elasticsearch, два logstash и две ноды kibana;
- Мониторинг-стек на базе Prometheus и Grafana;
- MongoDB, как основное хранилище данных для java-приложения;
- Gitlab сервер для реализации CI/CD процессов и приватный (закрытый) Docker Registry.  


## Решение
- Высоконагруженное монолитное java веб-приложение;
> Лучше аппаратная виртуализация. Виртуализация позволит настроить высокую отказоустойчивость  
> (быстрое переключение между активной и пасивной нодой, бэкапы).  
> Так как приложение высоконагруженное, потребуется много ресурсов.
- Nodejs веб-приложение;
> Для веб-приложений больше подойдет Docker, быстро поднимать + изолированная среда
- Мобильное приложение c версиями для Android и iOS;
> Настроить отдельные шаблоны ВМ (в шаблоне будут все необходимые тонкие настройки),  
> на хосте виртуализации поднимать изолированую ВМ из шаблона.
- Шина данных на базе Apache Kafka;
> Docker, есть образы для apache kafka, + изолированная среда, откат на стабильные версии в случае обнаружения багов
- Elasticsearch кластер для реализации логирования продуктивного веб-приложения - три ноды elasticsearch, два logstash и две ноды kibana;
> Затрудняюсь ответить. Скорее всего есть готовые docker контейнеры.
- Мониторинг-стек на базе Prometheus и Grafana;
> В среде виртуализации, vSphere например. Настройка отказаустойчивости (быстрое переключение между активной и пасивной нодой, бэкапы)  
> Для настройки на базе docker потребуется больше времени и более скилованные специалисты 
- MongoDB, как основное хранилище данных для java-приложения;
> В среде виртуализации, vSphere например. Настройка отказаустойчивости (быстрое переключение между активной и пасивной нодой, бэкапы).
- Gitlab сервер для реализации CI/CD процессов и приватный (закрытый) Docker Registry
> подойдет Docker, быстро поднимать + изолированная среда


## Задача 3
- Запустите первый контейнер из образа ***centos*** c любым тэгом в фоновом режиме, подключив папку ```/data``` из текущей рабочей директории на хостовой машине в ```/data``` контейнера;
- Запустите второй контейнер из образа ***debian*** в фоновом режиме, подключив папку ```/data``` из текущей рабочей директории на хостовой машине в ```/data``` контейнера;
- Подключитесь к первому контейнеру с помощью ```docker exec``` и создайте текстовый файл любого содержания в ```/data```;
- Добавьте еще один файл в папку ```/data``` на хостовой машине;
- Подключитесь во второй контейнер и отобразите листинг и содержание файлов в ```/data``` контейнера.  

## Решение


docker run -v /data:/data --name centos-container -d -t centos

docker run -v /data:/data --name debian-container -d -t debian

docker ps

```
root@vmubuntu:/var/lib/docker# docker ps  
CONTAINER ID   IMAGE     COMMAND       CREATED          STATUS          PORTS     NAMES
0a49077ebb32   debian    "bash"        46 seconds ago   Up 43 seconds             debian-container  
ee391b7c240b   centos    "/bin/bash"   3 minutes ago    Up 3 minutes              centos-container  
```

создаем файл в CentOS контейнере 

docker exec centos-container /bin/bash -c "echo test_message>/data/readme.md"

Добавляем еще один файл в папку /data на хостовой машине

nano /data/readme_host.md
test_message2

подключаемся в Debian контейнер 

root@vmubuntu:/var/lib/docker# docker exec -it debian-container /bin/bash  

root@0a49077ebb32:/# cd /data  

root@0a49077ebb32:/data# ls -lah  
total 16K  
drwxr-xr-x 2 root root 4.0K Jan 18 15:33 .  
drwxr-xr-x 1 root root 4.0K Jan 18 15:25 ..  
-rw-r--r-- 1 root root   13 Jan 18 15:31 readme.md  
-rw-r--r-- 1 root root   14 Jan 18 15:33 readme_host.md  

root@0a49077ebb32:/data#  
