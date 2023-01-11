

1 На лекции мы познакомились с node_exporter. В демонстрации его исполняемый файл запускался в background.   
Этого достаточно для демо, но не для настоящей production-системы,  
где процессы должны находиться под внешним управлением. Используя знания из лекции по systemd,   
создайте самостоятельно простой unit-файл для node_exporter:

поместите его в автозагрузку,
предусмотрите возможность добавления опций к запускаемому процессу через внешний файл  
(посмотрите, например, на systemctl cat cron),  
удостоверьтесь, что с помощью systemctl процесс корректно стартует, завершается,   
а после перезагрузки автоматически поднимается.

sudo su

cd /etc/

mkdir node_exporter

cd node_exporter/

wget https://github.com/prometheus/node_exporter/releases/download/v1.5.0/node_exporter-1.5.0.linux-amd64.tar.gz

tar xzf node_exporter-1.5.0.linux-amd64.tar.gz

cd node_exporter-1.5.0.linux-amd64

cp node_exporter /usr/local/bin/

cd /etc/systemd/system/

nano node_exporter.service

добавил информацию в файл 

[Unit]  
Description=Node Exporter Prometheus  
After=network.target  

[Service]  
User=root  
ExecStart=/usr/local/bin/node_exporter $OPTS  
Restart=on-failure  


[Install]  
WantedBy=multi-user.target



добавил в автозагрузку 

systemctl enable node_exporter

включил 

systemctl start node_exporter

systemctl status node_exporter

Скриншот 1

после перезагрузки ВМ  

node_exporter стартует автоматически

предусмотрена возможность добавления опций к запускаемому процессу через внешний файл

ExecStart=/usr/local/bin/node_exporter $OPTS

2 Ознакомьтесь с опциями node_exporter и выводом /metrics по-умолчанию. Приведите несколько опций,   
которые вы бы выбрали для базового мониторинга хоста по CPU, памяти, диску и сети.

curl http://localhost:9100/metrics - экспортируемые метрики 

curl http://localhost:9100/metrics | grep "node_cpu"

node_cpu_seconds_total{cpu="0",mode="system"} 25.81  
node_cpu_seconds_total{cpu="0",mode="user"} 15.09  
node_cpu_seconds_total{cpu="1",mode="idle"} 2317.71  

curl http://localhost:9100/metrics | grep "node_memory"

node_memory_MemAvailable_bytes 1.72691456e+09  
node_memory_MemFree_bytes 1.46223104e+09  
node_memory_MemTotal_bytes 2.079502336e+09  


curl http://localhost:9100/metrics | grep "node_disk"

node_disk_io_time_seconds_total{device="sda"} 27.62  
node_disk_read_time_seconds_total{device="sda"} 58.82  
node_disk_write_time_seconds_total{device="sda"} 10.782  

curl http://localhost:9100/metrics | grep "node_network"

node_network_receive_packets_total{device="eth0"} 1489  
node_network_transmit_bytes_total{device="eth0"} 148365  
node_network_transmit_errs_total{device="eth0"} 0

3 Установите в свою виртуальную машину Netdata.  
Воспользуйтесь готовыми пакетами для установки (sudo apt install -y netdata).

После успешной установки:

в конфигурационном файле /etc/netdata/netdata.conf в секции [web] замените значение с localhost на bind to = 0.0.0.0,  
добавьте в Vagrantfile проброс порта Netdata на свой локальный компьютер и сделайте vagrant reload:  
config.vm.network "forwarded_port", guest: 19999, host: 19999  
После успешной перезагрузки в браузере на своем ПК (не в виртуальной машине)   
вы должны суметь зайти на localhost:19999. Ознакомьтесь с метриками, которые по умолчанию собираются  
Netdata и с комментариями, которые даны к этим метрикам.

sudo apt install -y netdata

в /etc/netdata/netdata.conf

закомментировал bind socket to IP = 127.0.0.1
bind to = 0.0.0.0

в vagrandfile добавил  
config.vm.network "forwarded_port", guest: 19999, host: 19999  

vagrant reload

В браузере хоста открыл http://localhost:19999/

Скриншот 2

4 Можно ли по выводу dmesg понять, осознает ли ОС,   
что загружена не на настоящем оборудовании, а на системе виртуализации?

ОС понимает, что загружена в системе виртуализации

[    0.000000] DMI: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBox 12/01/2006  
[    0.000000] Hypervisor detected: KVM

5 Как настроен sysctl fs.nr_open на системе по-умолчанию? Определите, что означает этот параметр.  
Какой другой существующий лимит не позволит достичь такого числа (ulimit --help)?

ulimit --help

cat /proc/sys/fs/nr_open  
1048576

fs.nr_open - лимит на количество открытых дескрипторов

ulimit -Hn  
1048576

ulimit -Hn - жесткий лимит на пользователя

ulimit -Sn  
1024

ulimit -Sn - мягкий лимит на пользователя (увеличится в пределах жесткого лимита)


6 Запустите любой долгоживущий процесс (не ls, который отработает мгновенно, а, например, sleep 1h)   
в отдельном неймспейсе процессов; покажите, что ваш процесс работает под PID 1 через nsenter.   
Для простоты работайте в данном задании под root (sudo -i).   
Под обычным пользователем требуются дополнительные опции (--map-root-user) и т.д.

Запускаем два терминальных окна

1) окно    
sudo su

unshare --pid --fork --mount-proc sleep 1h &


2) окно   
sudo su  

ps -e | grep sleep  
   1359 pts/0    00:00:00 sleep  
   1655 pts/0    00:00:00 sleep  

nsenter --target 1655 --mount --uts --ipc --net --pid ps aux

Скриншот 3


7 Найдите информацию о том, что такое :(){ :|:& };:  
Запустите эту команду в своей виртуальной машине Vagrant с Ubuntu 20.04   
(это важно, поведение в других ОС не проверялось). Некоторое время все будет "плохо", после чего (минуты)   
– ОС должна стабилизироваться. Вызов dmesg расскажет, какой механизм помог автоматической стабилизации.
Как настроен этот механизм по-умолчанию, и как изменить число процессов, которое можно создать в сессии?

запуск :(){ :|:& };: 

Скриншот 4

Функция с именем ‘:‘, постоянно вызывает сама себя

Стабилизирует систему механизм по ограничению запускаемых процессов от пользователя 

Изменить лимиты можно путем редактирования файла /usr/lib/systemd/system/user-.slice.d/10-defaults.conf   
и установкой другого значения для параметра TasksMax.

nano /usr/lib/systemd/system/user-.slice.d/10-defaults.conf  


[Unit]  
Description=User Slice of UID %j  
Documentation=man:user@.service(5)  
After=systemd-user-sessions.service  
StopWhenUnneeded=yes  

[Slice]  
TasksMax=33%  





