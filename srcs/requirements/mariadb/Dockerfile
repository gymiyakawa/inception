FROM debian:buster

####	INSTALLING REQUIRED DEPENDENCIES
#	updates package handlers, installs mariadb and creates folder for msqld, changing it's
#	owner and group to mysqld
RUN apt-get update -y \
	&& apt upgrade -y \
	&& apt-get install mariadb-server -y \
	&& mkdir -p var/run/mysqld\
	&& chown -R mysql:mysql var/run/mysqld

#	copies from our local files into the Docker image.
#	in this case, we're copying the configuration files into the correct folder for mariadb
#	50-server: 50 is a convetion. The prefix is used to tell which conf files to load, as they
#	are loaded lexicographically.
COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

#	copies script into image, changes permissions to make it executable and runs it
COPY conf/initmysqld.sh /usr/local/bin
RUN chmod +x /usr/local/bin/initmysqld.sh

ENTRYPOINT ["/usr/local/bin/initmysqld.sh"]
