# !/bin/bash

service nginx start 
service php7.3-fpm start

service mysql start
# Настроить базу данных wordpress
echo "CREATE DATABASE wordpress;"| mysql -u root
echo "GRANT ALL PRIVILEGES ON wordpress.* TO 'root'@'localhost' WITH GRANT OPTION;"| mysql -u root
echo "FLUSH PRIVILEGES;"| mysql -u root
echo "update mysql.user set plugin='' where user='root';"| mysql -u root

# nginx -g 'daemon off;'

bash
