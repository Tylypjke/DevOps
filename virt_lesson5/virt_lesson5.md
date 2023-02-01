## Задача 1

Дайте письменые ответы на следующие вопросы:

В чём отличие режимов работы сервисов в Docker Swarm кластере: replication и global?  
Какой алгоритм выбора лидера используется в Docker Swarm кластере?  
Что такое Overlay Network?  

## Решение

В чём отличие режимов работы сервисов в Docker Swarm кластере: replication и global?  

replicated - пользователь указывает кол-во сервисов

global - сервис обязательно запускается на каждой ноде и в единственном экземпляре

Какой алгоритм выбора лидера используется в Docker Swarm кластере?  

Алгоритм raft
 
1 Кандидат получает большинство голосов (включая свой) и побеждает в выборах. Каждый сервер голосует в каждом сроке лишь единожды, за первого достучавшегося кандидата (с некоторым исключением, рассмотренным далее), поэтому набрать в конкретном сроке большинство голосов может только один кандидат. Победивший сервер становится лидером, начинает рассылать heartbeat и обслуживать запросы клиентов к кластеру.  

2 Кандидат получает сообщение от уже действующего лидера текущего срока или от любого сервера более старшего срока. В этом случае кандидат понимает, что выборы, в которых он участвует, уже не актуальны. Ему не остаётся ничего, кроме как признать нового лидера/новый срок и перейти в состояние фоловер.   

3 Кандидат не получает за некоторый таймаут большинство голосов. Такое может произойти в случае, когда несколько фоловеров становятся кандидатами, и голоса разделяются среди них так, что ни один не получает большинства. В этом случае срок заканчивается без лидера, а кандидат сразу же начинает новые выборы на следующий срок.   |

P.S. получается не должно быть четного кол-ва manager 

Что такое Overlay Network?  

Отдельная сеть, которая создается для связи с контейнерами


## Задача 2

Создать ваш первый Docker Swarm кластер в Яндекс.Облаке

Для получения зачета, вам необходимо предоставить скриншот из терминала (консоли), с выводом команды:

```
docker node ls
```

## Решение

https://itisgood.ru/2020/10/19/kak-ustanovit-docker-swarm-na-ubuntu-20-04/  

sudo nano /etc/hosts  
10.128.0.17	manager-01  
10.128.0.31	worker-01  
10.128.0.26	worker-02  


sudo apt update  
sudo apt install apt-transport-https ca-certificates curl software-properties-common  
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -  
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"  
sudo apt-get update  
apt-cache policy docker-ce  
sudo apt install docker-ce  

sudo systemctl status docker  


sudo usermod -aG docker yc-user  

на manager    

sudo docker swarm init --advertise-addr 10.128.0.17  

на хостах  
sudo docker swarm join --token SWMTKN-1-1brf022uxbfsgwavmy8w75ct9vv561p6jxflr8t774zvs85cvp-6e7ehx20lquxesww0k0gjmpnj 10.128.0.17:2377    

на манагере  
sudo docker node ls  

sudo docker service create --name web --replicas 2 --replicas-max-per-node 1 nginx:alpine  

docker service ls  

Скриншот 1  

![image](https://github.com/Tylypjke/DevOps/blob/3645f73b8f01fcb0a04a1122b54b8d7e85c3f4f5/virt_lesson5/1.JPG)

## Задача 3

Создать ваш первый, готовый к боевой эксплуатации кластер мониторинга, состоящий из стека микросервисов.

Для получения зачета, вам необходимо предоставить скриншот из терминала (консоли), с выводом команды:

```
docker service ls
```
https://gitlab.com/k11s-os/lessons/docker/-/tree/main/Swarm

sudo su 

устанавливаем Portainer

curl -L https://downloads.portainer.io/ce2-16/portainer-agent-stack.yml -o portainer-agent-stack.yml

docker stack deploy -c portainer-agent-stack.yml portainer

https://158.160.58.68:9443

копируем confiig файлы в portainer

в stack добавляем .env.sample и docker-compose.yml

запускаем 

Скриншот 2

![image](https://github.com/Tylypjke/DevOps/blob/3645f73b8f01fcb0a04a1122b54b8d7e85c3f4f5/virt_lesson5/2.JPG)