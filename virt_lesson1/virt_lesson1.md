# Задача 1
Опишите кратко, как вы поняли: в чем основное отличие полной (аппаратной) виртуализации,  
паравиртуализации и виртуализации на основе ОС.

a) Паравиртуализация она же программная   
Между хостом и ВМ есть прослойка ввиде ОС и программы гипервизора    
Работает медленнее, чем аппаратная    

При данном типе виртуализации ОС работают на большем, чем 0 уровнем приоритета доступа к аппаратным   
ресурсам хоста. 

Например: VirtualBox

б) Аппаратная вируализация   
Между хостом и ВМ нет прослойки, аппаратные ресурсы выдаются напрямую в ВМ   
Хост забирает на себя функции ОС и программы гипервизора   
работает быстрее, чем программная  

В ЦП добавлены инструкции, позволяющие ОС выполнять все процессы напрямую в ЦП.   
При данном типе виртуализации ОС работают с 0 уровнем приоритета доступа к аппаратным ресурсам хоста.

Например: ESXi

в) Уровня ОС   
ВМ создаются на базе ОС хоста  
ВМ создаются легковесные, но это не полноценные ВМ, как например в аппаратной  
Например: Docker


# Задача 2
Выберите один из вариантов использования организации физических серверов,   
в зависимости от условий использования.

Организация серверов:
физические сервера,  
паравиртуализация,  
виртуализация уровня ОС.  

Условия использования:  
Высоконагруженная база данных, чувствительная к отказу.  
Различные web-приложения.  
Windows системы для использования бухгалтерским отделом.  
Системы, выполняющие высокопроизводительные расчеты на GPU.  
Опишите, почему вы выбрали к каждому целевому использованию такую организацию.  


А) Аппартаная   
Системы, выполняющие высокопроизводительные расчеты на GPU.  
Высоконагруженная база данных, чувствительная к отказу.   
Windows системы для использования бухгалтерским отделом.* - например 1С  уже требовательное ПО для бухгалтерии 

Аппаратная виртуализация отвечает требованиям отклика и отказаустойчевости 


Б) Программная   
Windows системы для использования бухгалтерским отделом.  

Если совсем небольшая компания, программы абсолютно не требовательные. 

В) Виртуализация уровня ОС  
Различные web-приложения

Например разработчикам надо быстро что-то проверить и не требуется полноценная ВМ


# Задача 3
Выберите подходящую систему управления виртуализацией для предложенного сценария.  
Детально опишите ваш выбор.

Сценарии:

1 100 виртуальных машин на базе Linux и Windows, общие задачи, нет особых требований.  
Преимущественно Windows based инфраструктура, требуется реализация программных балансировщиков нагрузки,   
репликации данных и автоматизированного механизма создания резервных копий. 

Если инфраструктура на Windows, значит есть лицензии Microsoft 

Базовые задачи закрываются ПО от Microsoft

Я выбираю Hyper-V на базе Windows Server  
^_^ тут такая реклама из Японии   
https://www.youtube.com/watch?v=_U92X0-NH-s  


2 Требуется наиболее производительное бесплатное open source решение   
для виртуализации небольшой (20-30 серверов) инфраструктуры на базе Linux и Windows виртуальных машин.

На мой взгляд, как наиболее производительное бесплатное решение, подойдет XenServer Free

Быстрота и надежность 

3 Необходимо бесплатное, максимально совместимое и производительное   
решение для виртуализации Windows инфраструктуры.

На мой взгляд, подходит KVM + Proxmox

Базовые информационные системы будут работать 

4 Необходимо рабочее окружение для тестирования программного продукта на нескольких дистрибутивах Linux.

Для разработчиков подходит Docker 

Быстро разварачивается, протестировали, закрыли.

# Задача 4

Опишите возможные проблемы и недостатки гетерогенной среды виртуализации   
(использования нескольких систем управления виртуализацией одновременно)   
и что необходимо сделать для минимизации этих рисков и проблем. Если бы у вас был выбор,   
то создавали бы вы гетерогенную среду или нет? Мотивируйте ваш ответ примерами.  

Мое мнение - это плохая идея

 Городить огороды

1 Потребуются разной заточки специалисты (один в основом работает с VMWare, второй с Hyper-V, другой KVM)  
и нанимать дополнительных инженеров 

2 Постоянно допиливать разные системы, + закупка дополнительных лицензий

3 Понадобится больше физических машин. (Под каждую среду своё оборудование)

На своем опыте встречал такое, но там были абсолютно не пересекающиеся проекты 

