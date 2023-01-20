## Задача 1

Установите Bitwarden плагин для браузера. Зарегестрируйтесь и сохраните несколько паролей.

## Решение

Скриншот 1

## Задача 2 

Установите Google authenticator на мобильный телефон. Настройте вход в Bitwarden акаунт через Google authenticator OTP.

## Решение

Скриншот 2

## Задача 3 
Установите apache2, сгенерируйте самоподписанный сертификат, настройте тестовый сайт для работы по HTTPS.

## Решение

sudo apt update

sudo apt install apache2

Cоздаем самоподписанный ключ и сертификат OpenSSL

sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/apache-selfsigned.key -out /etc/ssl/certs/apache-selfsigned.crt

sudo nano /etc/apache2/conf-available/ssl-params.conf

```
SSLCipherSuite EECDH+AESGCM:EDH+AESGCM:AES256+EECDH:AES256+EDH
SSLProtocol All -SSLv2 -SSLv3 -TLSv1 -TLSv1.1
SSLHonorCipherOrder On
# Disable preloading HSTS for now.  You can use the commented out header line that includes
# the "preload" directive if you understand the implications.
# Header always set Strict-Transport-Security "max-age=63072000; includeSubDomains; preload"
Header always set X-Frame-Options DENY
Header always set X-Content-Type-Options nosniff
# Requires Apache >= 2.4
SSLCompression off
SSLUseStapling on
SSLStaplingCache "shmcb:logs/stapling-cache(150000)"
# Requires Apache >= 2.4.11
SSLSessionTickets Off
```

sudo cp /etc/apache2/sites-available/default-ssl.conf /etc/apache2/sites-available/default-ssl.conf.bak

sudo nano /etc/apache2/sites-available/default-ssl.conf

```
<IfModule mod_ssl.c>
        <VirtualHost _default_:443>
                ServerAdmin your_email@example.com
                ServerName localhost

                DocumentRoot /var/www/html

                ErrorLog ${APACHE_LOG_DIR}/error.log
                CustomLog ${APACHE_LOG_DIR}/access.log combined

                SSLEngine on

                SSLCertificateFile      /etc/ssl/certs/apache-selfsigned.crt
                SSLCertificateKeyFile /etc/ssl/private/apache-selfsigned.key

                <FilesMatch "\.(cgi|shtml|phtml|php)$">
                                SSLOptions +StdEnvVars
                </FilesMatch>
                <Directory /usr/lib/cgi-bin>
                                SSLOptions +StdEnvVars
                </Directory>

        </VirtualHost>
</IfModule>
```
sudo nano /etc/apache2/sites-available/000-default.conf

```
<VirtualHost *:80>
        . . .

        Redirect "/" "https://localhost/"

        . . .
</VirtualHost>
```

sudo a2enmod ssl

sudo a2enmod headers

sudo a2ensite default-ssl

sudo a2enconf ssl-params

sudo apache2ctl configtest

sudo systemctl restart apache2

в Vagrantfile 

пробросить 443 порт 

config.vm.network "forwarded_port", guest: 443, host: 4433

Скриншот 3

## Задача 4 
Проверьте на TLS уязвимости произвольный сайт в интернете (кроме сайтов МВД, ФСБ, МинОбр, НацБанк, РосКосмос, РосАтом, РосНАНО и любых госкомпаний, объектов КИИ, ВПК ... и тому подобное).

## Решение

vagrant@vagrant:~$ pwd
/home/vagrant

git clone --depth 1 https://github.com/drwetter/testssl.sh.git 

cd testssl.sh

./testssl.sh -U --sneaky https://netology.ru/

Скриншот 4

## Задача 5 

Установите на Ubuntu ssh сервер, сгенерируйте новый приватный ключ. Скопируйте свой публичный ключ на другой сервер.  
Подключитесь к серверу по SSH-ключу.

## Решение

ssh service можно установить при установки ОС

sudo apt install openssh-server  
sudo systemctl start sshd.service  
sudo systemctl enable sshd.service  

ssh-keygen

Подключился по ssh к двум серверам 

Скриншот 5 и 6

## Задача 6
Переименуйте файлы ключей из задания 5.   
Настройте файл конфигурации SSH клиента, так чтобы вход на удаленный сервер осуществлялся по имени сервера.

## Решение

cd /home/user/.ssh/

mv id_rsa id_rsa_rename

mv id_rsa.pub id_rsa.pub_rename

nano config

Host vm1
        HostName 192.168.0.55
        User user
        Port 22
        IdentityFile ~/.ssh/id_rsa_rename

подключаемся по имени vm1

ssh vm1

Скриншот 7

## Задача 7
Соберите дамп трафика утилитой tcpdump в формате pcap, 100 пакетов. Откройте файл pcap в Wireshark.

## Решение

sudo tcpdump -c 100 -w for_analyze_wireshark.pcap

tcpdump: listening on ens32, link-type EN10MB (Ethernet), snapshot length 262144 bytes  
100 packets captured  
197 packets received by filter  
0 packets dropped by kernel  

открыл файл в wireshark

Скриншот 8
