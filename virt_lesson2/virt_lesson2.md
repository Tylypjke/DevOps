# Задача 1
Опишите своими словами основные преимущества применения на практике IaaC паттернов.  
Какой из принципов IaaC является основополагающим?

Устраняет вероятность совершить ошибку на отдельном сервере 

Если требуется развернуть большую инфраструктуру, сокращает время

Маштабируемость, быстро развернуть

Бэкап 

Описание назначения ВМ 

Основопологающие принципы

Быстрое создание идентичной конфигурации

Например быстро создать стенд и проверить/исправить в тестовой зоне. 


# Задача 2

Чем Ansible выгодно отличается от других систем управление конфигурациями?
Какой, на ваш взгляд, метод работы систем конфигурации более надёжный push или pull?

Не требуется установка клиентской части

Использует распространённый язык Python 

Большое комьюнити, позволяет найти много информации

интересная статья https://habr.com/ru/company/flant/blog/456754/

Как обычно это бывает, у каждого подхода есть свои плюсы и минусы.   
Возможно push надёжней, т.к. централизованно управляет конфигурацией и исключает ситуации,   
когда прямое изменеие
на сервере не отразится в репозитории, что может привести к непредсказуемым ситуациям.   
Возможно pull безопаснее,
поскольку учетные данные кластера недоступны за его пределами. Но если кто-то получит доступ 
в ваш репозиторий git и сможет push'ить
туда код, то он сможет развернуть все, что пожелает   
(независимо от выбранного подхода, будет это pull или push),
и внедриться в системы кластера. Таким образом, наиболее важными   
компонентами, требующими защиты, являются git-репозиторий
и CI/CD-системы, а не учетные данные кластера.


# Задача 3

Установить на личный компьютер:

VirtualBox  
Vagrant  
Ansible  
Приложить вывод команд установленных версий каждой из программ, оформленный в markdown.  


установил WSL

Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux

Через Microsoft Store установил Ubuntu 18.04 LTS.  

Установил ansible 

$ sudo apt update  
$ sudo apt install software-properties-common  
$ sudo apt-add-repository --yes --update ppa:ansible/ansible  
$ sudo apt install ansible  

остальное ПО установлено в Windows 

PS C:\> vagrant -v  
Vagrant 2.3.3  
PS C:\> vboxmanage --version  
7.0.4r154605  
PS C:\> wsl ansible --version  
ansible 2.9.27  
  config file = /etc/ansible/ansible.cfg  
  configured module search path = [u'/home/user/.ansible/plugins/modules',  
u'/usr/share/ansible/plugins/modules']  
  ansible python module location = /usr/lib/python2.7/dist-packages/ansible  
  executable location = /usr/bin/ansible  
  python version = 2.7.17 (default, Nov 28 2022, 18:51:39) [GCC 7.5.0]  
PS C:\>  

Скриншот 1

# Задача 4

Удалил vagrant в Windows 

Установил vagrant в WSL

Добавил inventory (hosts), ansible, playbook, Vagrantfile в директорию с .vagrant

Настройка Vagrant в WSL для использования VirtualBox в Windows

export VAGRANT_WSL_ENABLE_WINDOWS_ACCESS="1"

export PATH="${PATH}:/mnt/c/Program Files/Oracle/VirtualBox"

При ошибке WARNING: UNPROTECTED PRIVATE KEY FILE!, требуется поменять права на ssh ключ 

Права в WSL просто так не поменять

chmod 600 /mnt/c/Users/admin/.vagrant/machines/server1.netology/virtualbox/private_key 

wsl chmod 600 /mnt/c/Users/admin/.vagrant/machines/server1.netology/virtualbox/private_key 

Не работает 

Помогло создать файл   
/etc/wsl.conf  
c информацией  
[automount]  
options = "metadata"  

перезагрузил WSL

команда chmod выполнена 

vagrant up

vagrant provision

vagrant ssh

docker установлен 

Скриншот 2