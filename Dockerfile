# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: tchariss <tchariss@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/03/31 19:13:43 by tchariss          #+#    #+#              #
#    Updated: 2021/04/04 14:35:51 by tchariss         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# Это один из дистрибутивов(версия) Linux состоящий из бесплатного программного обеспечения с открытым исходным кодом
# Команда < screenfetch >  -> показывает дистрибутив 
FROM debian:buster 

# # # # # # 
# wget -> это программа для "вытягивания" файлов из Internet при помощи протоколов HTTP или FTP (пакет менеджеров)
# Wget - текстовая программа для скачивания файлов
# (Для того чтобы установить Wordpress и PhpMyAdmin)

# Обновить пакеты && установить 
RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get -y install nginx openssl
RUN apt-get -y install wget
# буду работать в терминале (вносить изменения) 
RUN apt-get -y install vim

# # # # # # # # # # # # # # 
# nginx
# nginx - это веб-сервер, который предоставляет только статический контент
COPY ./srcs/default /etc/nginx/sites-available/default
RUN ln -sf /etc/nginx/sites-available/default /etc/nginx/sites-enabled/
# 1.nginx.conf - общие конфиги всего сервера и всех обслуживаемых сайтов, там он подключает что лежит в site-enabled
# 2.site-available - конфиги отдельных приложений
# 3.sites-enabled - ссылки на конфиги из sites-available, складываются ссылки из site-available,чтобы быстро включить, отключить какой-либо конфиг

# // SSL сертификат // #
# RUN openssl req -x509 -nodes -days 121 -newkey rsa:2048 -subj "/C=RU/ST=Msk/L=City/O=Organ/OU=Sch/CN=21"
RUN openssl req -x509 -nodes -days 123 -newkey rsa:4096 \ 
    -keyout /etc/ssl/ssl.key \
    -out /etc/ssl/ssl.crt \
    -subj "/C=RU/ST=Vyatskay/L=Moscow/O=School/OU=21/CN=tchariss"

# C	- Страна / Задает код ISO, представляющий страну, двухзначный код
# ST - Улица, остальная часть адреса
# L	- Город / Населенный пункт
# О	- Название организации
# ОU - Команды внутри компании / организации
# CN - Распространенное имя / Отличительное имя сертификата

# req: Запрос сертификата и утилита создания сертификата (позволит создать localhost.dev.key и localhost.dev.crt файлы)
# newkey: Возможность сгенерировать закрытый ключ
# days 365: Срок действия сертификата (любое)
# nodes: если не указано, мы должны вручную вводить пароль
# rsa: команда для генерации пароля из байтов (шифрование)

# ssl - keyout <имя файла ключей>: создать файл ключей, указать имя
# ssl - out <Имя сертификата>: создать сертификат, указать имя

# # # # # # # # # # # # # # 
# PHP -> Personal Home Page Tools — «Инструменты для создания персональных веб-страниц» -> «оживление» HTML страниц
# PHP один из крупнейших языков программирования с открытым исходным кодом, используемых в Интернете
# PHP расширения // Nginx не поддерживает встроенную обработку PHP

# Cчитывает динамический контент вместо веб-сервера, конвертирует его в HTML и доставляет обратно на веб-сервер
RUN apt-get -y install php7.3
# Чтобы PHP-код работал на сервере Nginx и взаимодействовал с базой данных mySQL
RUN apt-get -y install php-mysql
# Управляет строками, отличными от ASCII, и преобразует строки в разные кодировки
RUN apt-get -y install php-mbstring 
# php-fpm (менеджер обработки fastCGI) - (клиент-серверный протокол взаимодействия веб-сервера и приложения)
# Nginx обрабатывает только HTTP-запросы, а PHP-FPM интерпретирует(объясняет) код PHP 
RUN apt-get -y install php-fpm 
# При запуске в командной строке (Command Line Interface - интерфейс командной строки)
RUN apt-get -y install php-cli 
# Поддерживает загрузку файлов .zip в phpMyAdmin
RUN apt-get -y install php-zip 
# Вместо mysql(мгновенный запуск)
RUN apt-get -y install mariadb-server

# Создаю папку в которую я буду все закидывать 
RUN mkdir /var/www/tchariss

# # # # # # # # # # # # # #
# phpMyAdmin     --    php для создания динамических страниц
# Когда код, написанный на PHP, добавляется в код HTML, веб-сервер интерпретирует код PHP и создает динамическую веб-страницу
# - Один из инструментов управления БД
# - Тип клиента базы данных (= браузер базы данных, такой как веб-браузер, а не сама база данных)
# - Доступен в виде веб-сайта (страницы)
# - Перед установкой необходимо установить php и (MariaDB или MySQL)
RUN wget https://files.phpmyadmin.net/phpMyAdmin/4.9.5/phpMyAdmin-4.9.5-all-languages.tar.gz
RUN tar -xf phpMyAdmin-4.9.5-all-languages.tar.gz
RUN rm -rf phpMyAdmin-4.9.5-all-languages.tar.gz
RUN mv phpMyAdmin-4.9.5-all-languages /var/www/tchariss/phpMyAdmin
COPY ./srcs/config.inc.php ./var/www/tchariss/phpMyAdmin/config.inc.php

# # # # # # # # # # # # # #
# Wordpress -  система управления содержимым сайта с открытым исходным кодом
# Написана на PHP; сервер базы данных — MySQL(MariaDB)
RUN wget https://wordpress.org/latest.tar.gz
RUN tar -xf latest.tar.gz
RUN rm -rf latest.tar.gz
RUN mv wordpress ./var/www/tchariss/wordpress
COPY ./srcs/wp-config.php ./var/www/tchariss/wordpress

RUN chown -R www-data var/www/tchariss
RUN chmod -R 755 /var/www/tchariss/*

COPY ./srcs/start.sh ./

CMD bash start.sh
