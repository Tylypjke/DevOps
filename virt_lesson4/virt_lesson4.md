## Задача 1

Создать собственный образ любой операционной системы (например, centos-7) с помощью Packer 

## Решение

curl -L "https://github.com/docker/compose/releases/download/v2.15.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/bin/docker-compose

chmod +x /usr/bin/docker-compose

docker-compose version

curl -sSL https://storage.yandexcloud.net/yandexcloud-yc/install.sh | bash

cd /root/

cp yandex-cloud/bin/yc /usr/bin/

yc init


yc vpc network create --name net --labels my-label=netology --description "My network"  

id: enpse8p08i0hjqhjv991  
folder_id: b1g7mptaldhcjovk8r3q  
created_at: "2023-01-23T08:51:42Z"  
name: net  
description: My network  
labels:  
  my-label: netology  

yc vpc subnet create --name my-subnet-a --zone ru-central1-a --range 10.1.2.0/24 --network-name net --description "My subnet"

id: e9bit3k7n9v5hlaonljf  
folder_id: b1g7mptaldhcjovk8r3q  
created_at: "2023-01-23T08:56:31Z"  
name: my-subnet-a  
description: My subnet  
network_id: enpse8p08i0hjqhjv991  
zone_id: ru-central1-a  
v4_cidr_blocks:  
  - 10.1.2.0/24  

создаем конфигурационный файл centos7.json

yc config list

Устанавливаем packer

cd /home/user/

wget https://hashicorp-releases.yandexcloud.net/packer/1.8.5/packer_1.8.5_linux_386.zip

apt install unzip

unzip packer_1.8.5_linux_386.zip

cp packer /usr/bin/

packer validate /home/user/centos7.json

packer build /home/user/centos7.json

yc compute image list

Скриншот 1 и 2


## Задача 2

Создать вашу первую виртуальную машину в YandexCloud.


## Решение

Установка Terraform 

wget https://hashicorp-releases.yandexcloud.net/terraform/1.3.7/terraform_1.3.7_linux_386.zip

unzip terraform_1.3.7_linux_386.zip

cp terraform /usr/bin/

статья https://cloud.yandex.ru/docs/tutorials/infrastructure-management/terraform-quickstart#get-credentials

создаем сервисный аккаунт

генерируем ключ 

root@vmubuntu:/home/user# terraform --version  
Terraform v1.3.7  
on linux_386   
root@vmubuntu:/home/user# terraform init  
Terraform initialized in an empty directory!  

Терраформ сообщает ошибку 

```
Initializing provider plugins...
- Finding latest version of hashicorp/yandex...
╷
│ Error: Failed to query available provider packages
│
│ Could not retrieve the list of available versions for provider hashicorp/yandex: could
│ not connect to registry.terraform.io: Failed to request discovery document: 403
│ Forbidden
```

Создал руками 

скриншот 3

## Задача 3

Создать ваш первый готовый к боевой эксплуатации компонент мониторинга, состоящий из стека микросервисов.

## Решение

скриншот 4