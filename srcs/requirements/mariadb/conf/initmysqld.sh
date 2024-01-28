#!/bin/sh

#	mysql starts in the background for its setup. it is then shutdown and restarted in the foreground
#	for it's actual execution.
mysqld &

sleep 10

#	database creation
mysql -u root -p$SQL_ROOT_PASSWORD -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;"
#	user creation
mysql -u root -p$SQL_ROOT_PASSWORD -e "CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'localhost' IDENTIFIED BY '${SQL_PASSWORD}';"
#	granting it privileges
mysql -u root -p$SQL_ROOT_PASSWORD -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';"
#	changing root password
mysql -u root -p$SQL_ROOT_PASSWORD -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';"
#	reloads priviledges to apply changes
mysql -u root -p$SQL_ROOT_PASSWORD -e "FLUSH PRIVILEGES;"

#	shuts down server
mysqladmin -u root -p$SQL_ROOT_PASSWORD -S /var/run/mysqld/mysqld.sock shutdown

sleep 5

#restarting sql to apply changes
exec mysqld_safe