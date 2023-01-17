# 1 Работа c HTTP через телнет.

Подключитесь утилитой телнет к сайту stackoverflow.com telnet stackoverflow.com 80  
Отправьте HTTP запрос  

GET /questions HTTP/1.0  
HOST: stackoverflow.com  
  

В ответе укажите полученный HTTP код, что он означает?

user@vm:~$ telnet stackoverflow.com 80  
Trying 151.101.65.69...  
Connected to stackoverflow.com.  
Escape character is '^]'.  
GET /questions HTTP/1.0  
HOST: stackoverflow.com  

HTTP/1.1 403 Forbidden  
Connection: close  
Content-Length: 1920  
Server: Varnish  
Retry-After: 0  
Content-Type: text/html  
Accept-Ranges: bytes  
Date: Tue, 17 Jan 2023 12:38:13 GMT  
Via: 1.1 varnish  
X-Served-By: cache-fra-eddf8230138-FRA  
X-Cache: MISS  
X-Cache-Hits: 0  
X-Timer: S1673959094.525113,VS0,VE1  
X-DNS-Prefetch-Control: off  

Скорее всего закрыли доступ по протоколу HTTP порт 80

Скриншот 1


# 2 Повторите задание 1 в браузере, используя консоль разработчика F12.
откройте вкладку Network  
отправьте запрос http://stackoverflow.com  
найдите первый ответ HTTP сервера, откройте вкладку Headers  
укажите в ответе полученный HTTP код  
проверьте время загрузки страницы, какой запрос обрабатывался дольше всего?  
приложите скриншот консоли браузера в ответ.  

Request URL: http://stackoverflow.com/  
Request Method: GET  
Status Code: 307 Internal Redirect  
Referrer Policy: strict-origin-when-cross-origin  
Cross-Origin-Resource-Policy: Cross-Origin  
Location: https://stackoverflow.com/  
Non-Authoritative-Reason: HSTS  
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,  
*/*;q=0.8,application/signed-exchange;v=b3;q=0.9    
Upgrade-Insecure-Requests: 1  
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36   
(KHTML, like Gecko) Chrome/108.0.0.0 Safari/537.36  

Страница загрузилась за Load: 1.74 s  
Самый долгий запрос скриншот 3

# 3 Какой IP адрес у вас в интернете?

Можно зайти на сайт https://2ip.ru/

либо команда в линукс wget -qO- eth0.me

# 4 Какому провайдеру принадлежит ваш IP адрес? Какой автономной системе AS? Воспользуйтесь утилитой whois

sudo apt-get install whois

whois внешний ip 

Сообщается полная открытая информация про внешний ip адрес 

# 5 Через какие сети проходит пакет, отправленный с вашего компьютера на адрес 8.8.8.8?   
Через какие AS? Воспользуйтесь утилитой traceroute

sudo apt install traceroute 

traceroute -An 8.8.8.8

traceroute to 8.8.8.8 (8.8.8.8), 30 hops max, 60 byte packets  
 1  *.*.*.* [*]  0.336 ms  0.484 ms  0.532 ms  
 2  195.96.77.209 [AS8359]  1.910 ms  1.921 ms  1.882 ms  
 3  10.220.16.64 [*]  2.494 ms  2.499 ms  2.875 ms  
 4  176.241.99.237 [AS8359]  2.749 ms  2.836 ms  2.747 ms  
 5  * * *  
 6  212.188.28.14 [AS8359]  3.329 ms  2.238 ms  2.413 ms  
 7  74.125.49.108 [AS15169]  2.614 ms  2.631 ms  2.620 ms  
 8  * * *  
 9  209.85.240.254 [AS15169]  3.080 ms  3.032 ms  3.054 ms  
10  74.125.244.180 [AS15169]  3.505 ms 74.125.244.181 [AS15169]  3.538 ms 74.125.244.180 [AS15169]  3.505 ms  
11  72.14.232.85 [AS15169]  2.836 ms 142.251.51.187 [AS15169]  6.118 ms 72.14.232.85 [AS15169]  2.786 ms  
12  142.250.238.181 [AS15169]  6.915 ms 142.251.61.221 [AS15169]  6.866 ms 216.239.48.163 [AS15169]  5.982 ms  
13  172.253.79.115 [AS15169]  5.930 ms * *  
14  * * *    

15  * * *  

16  * * *  

17  * * *  

18  * * * 

19  * * * 

20  * * *  

21  * * *  

22  8.8.8.8 [AS15169/AS263411]  5.732 ms  6.035 ms  6.085 ms  


Пакет проходит через AS - AS8359, AS15169, AS263411

whois AS8359

whois AS15169 

whois AS263411

# 6 Повторите задание 5 в утилите mtr. На каком участке наибольшая задержка - delay?

mtr 8.8.8.8 -znrc 1  

вывод в скриншоте 4

Наибольшая задержка на 11 хопе   
 11. AS15169  142.250.208.23       0.0%     1    6.7   6.7   6.7   6.7   0.0


# 7 Какие DNS сервера отвечают за доменное имя dns.google? Какие A записи? Воспользуйтесь утилитой dig

NS записи   
user@vmubuntu:~$ dig +short NS dns.google  
ns1.zdns.google.  
ns3.zdns.google.  
ns4.zdns.google.  
ns2.zdns.google.  

А записи  
user@vmubuntu:~$ dig +short A dns.google  
8.8.8.8  
8.8.4.4  


# 8 Проверьте PTR записи для IP адресов из задания 7. Какое доменное имя привязано к IP? Воспользуйтесь утилитой dig

dig -x 8.8.8.8

8.8.8.8.in-addr.arpa.   82951   IN      PTR     dns.google.

dig -x 8.8.4.4

4.4.8.8.in-addr.arpa.   86400   IN      PTR     dns.google.

К ip привязано DNS dns.google.




