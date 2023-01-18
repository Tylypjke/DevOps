# 1 Узнайте о sparse (разряженных) файлах.

Sparse (разрежённые файлы) - файлы в котором последовательности нулевых байтов, но сохраняется информация 
 об этих последовательностях (список дыр)

Дыра (англ. hole) — последовательность нулевых байт внутри файла, не записанная на диск.   
Информация о дырах (смещение от начала файла в байтах и количество байт) хранится в метаданных ФС 

ФС - Файловая система

Нулевой байт — байт, все биты которого установлены в ноль (0, NUL или '\0' в Си).

Преимущества sparse файлов:  
Система быстрее работает с данными файлами  
Меньше занимают пространство 
Увеличение срока службы запоминающих устройств (меньше операций на физических дисках)

Недостатки sparse файлов: 
Системе требуется больше время на работу с данным файлом 


# 2 Могут ли файлы, являющиеся жесткой ссылкой на один объект, иметь разные права доступа и владельца? Почему?

Жесткая ссылка – тот же самый файл, с теми же атрибутами, что и оригинальный файл. Права доступа будут одинаковыми.

# 3 Сделайте vagrant destroy на имеющийся инстанс Ubuntu. Замените содержимое Vagrantfile следующим.

 Vagrant.configure("2") do |config|  
      config.vm.box = "bento/ubuntu-20.04"  
      config.vm.provider :virtualbox do |vb|  
        lvm_experiments_disk0_path = "/tmp/lvm_experiments_disk0.vmdk"  
        lvm_experiments_disk1_path = "/tmp/lvm_experiments_disk1.vmdk"  
        vb.customize ['createmedium', '--filename', lvm_experiments_disk0_path, '--size', 2560]  
        vb.customize ['createmedium', '--filename', lvm_experiments_disk1_path, '--size', 2560]  
        vb.customize ['storageattach', :id, '--storagectl', 'SATA Controller', '--port', 1, '--device', 0, '--type', 'hdd', '--medium', lvm_experiments_disk0_path]  
        vb.customize ['storageattach', :id, '--storagectl', 'SATA Controller', '--port', 2, '--device', 0, '--type', 'hdd', '--medium', lvm_experiments_disk1_path]  
      end  
    end  
 
Создана ВМ с данной конфигурацией 

# 4 Используя fdisk, разбейте первый диск на 2 раздела: 2 Гб, оставшееся пространство.

lsblk

sudo fdisk /dev/sdb

Скриншот 1

# 5 Используя sfdisk, перенесите данную таблицу разделов на второй диск.

sudo sfdisk -d /dev/sda > sda.txt

sudo sfdisk -d /dev/sdb > sdb.txt

sudo sfdisk /dev/sdc < sdb.txt

Скриншот 2

# 6 Соберите mdadm RAID1 на паре разделов 2 Гб.

sudo mdadm --create --verbose /dev/md1 --level=1 --raid-devices=2 /dev/sdb1 /dev/sdc1

Скриншот 3 

# 7 Соберите mdadm RAID0 на второй паре маленьких разделов.

sudo mdadm --create --verbose /dev/md2 --level=0 --raid-devices=2 /dev/sdb2 /dev/sdc2

Скриншот 4

# 8 Создайте 2 независимых PV на получившихся md-устройствах.

sudo pvscan

sudo pvcreate /dev/md1 /dev/md2

Скриншот 5 

# 9 Создайте общую volume-group на этих двух PV.

sudo vgcreate volume_group /dev/md126 /dev/md127

Скриншот 6 

# 10 Создайте LV размером 100 Мб, указав его расположение на PV с RAID0.

sudo lvcreate -L 100M -n logical_volume1 volume_group /dev/md127

Скриншот 7 

# 11 Создайте mkfs.ext4 ФС на получившемся LV.

sudo mkfs.ext4 /dev/volume_group/logical_volume1

Скриншот 8 

# 12 Смонтируйте этот раздел в любую директорию, например, /tmp/new.

sudo mkdir -p /tmp/new/logical_volume1

sudo mount /dev/volume_group/logical_volume1 /tmp/new/logical_volume1/

df -Th

# 13 Поместите туда тестовый файл, например wget https://mirror.yandex.ru/ubuntu/ls-lR.gz -O /tmp/new/test.gz.

Скриншот 9

# 14 Прикрепите вывод lsblk.

Скриншот 10

# 15 Протестируйте целостность файла:

root@vagrant:~# gzip -t /tmp/new/test.gz  
root@vagrant:~# echo $?  
0  

vagrant@vagrant:~$ sudo gzip -t /tmp/new/logical_volume1/test.gz.  
vagrant@vagrant:~$ echo $?  
0  

Скриншот 11

# 16 Используя pvmove, переместите содержимое PV с RAID0 на RAID1.

sudo pvmove -n /dev/volume_group/logical_volume1 /dev/md127 /dev/md126

Скриншот 12

# 17 Сделайте --fail на устройство в вашем RAID1 md.

sudo mdadm /dev/md126 --fail /dev/sdb1

mdadm: set /dev/sdb1 faulty in /dev/md126

# 18 Подтвердите выводом dmesg, что RAID1 работает в деградированном состоянии.

Скриншот 13

# 19 Протестируйте целостность файла, несмотря на "сбойный" диск он должен продолжать быть доступен:

root@vagrant:~# gzip -t /tmp/new/test.gz  
root@vagrant:~# echo $?  
0  

Скриншот 14

# 20 Погасите тестовый хост, vagrant destroy.

Vagrant destroy


