FROM debian:buster

###### INSTALLING BASIC DEPENDENCIES

#	wget - package handler for retrieving files using HTTP(s) and FTP(s)
#	php7.3 - lastest version for debian:buster
#	php-fpm - php FastCGI Process Manager - handles CGI script running
#	php-mysql - php extension that provides connectivity for MySQL databases. Allows
#				PHP scripts to interact with those databases by providing functions and
#				and features for connecting to MySQl servers
#	mariadb-client	- provide command-line tools for interacting with mariadb databases

RUN apt update -y \
	&& apt upgrade -y \
	&& apt-get -y install wget php7.3 php-fpm php-mysql mariadb-client
	
##### INSTALLING WORDPRESS

#	Download WordPress archive as wordpress.tar.gz and save it to /var/www/html
#	cd into the directory, extract using the flags -xzvf
#					-x: Extract files from an archive.
#					-z: Filter the archive through gzip to decompress it.
#					-v: Verbosely list the files processed.
#					-f: Use archive file specified (in this case, wordpress.tar.gz).
#	remove the compressed file
#	change ownership -R (recursive) of the files to the root user and group

# RUN wget https://wordpress.org/latest.tar.gz -P /var/www \
# 	&& cd /var/www \
# 	&& tar -xzf latest.tar.gz \
# 	&& rm latest.tar.gz \
# 	&& chown -R root:root /var/www/wordpress
	
	RUN wget https://fr.wordpress.org/wordpress-6.3.1-fr_FR.tar.gz -P /var/www \
    && cd /var/www\
    && tar -xzf wordpress-6.3.1-fr_FR.tar.gz\
    && rm wordpress-6.3.1-fr_FR.tar.gz\
    # La commande chown -R est utilisée pour modifier le propriétaire et le groupe d'un fichier ou d'un répertoire
    && chown -R root:root /var/www/wordpress
	
	
	
	
	
	
	
	
	

# copies config files to the image
COPY conf/www.conf /etc/php/7.3/fpm/pool.d/www.conf

#	Installing worpress CLI (command line interface)
#	changing permissions to make it executable
#	moving it into the binaries
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
	&& chmod +x wp-cli.phar\
	&& mv wp-cli.phar /usr/local/bin/wp-cli.phar
	
	
##### WORDPRESS CONFIGURATION

#	Copy auto_config into image
#	create php directory 
#	change permissions to make auto_config executable

COPY conf/auto_config.sh /usr/local/bin/auto_config.sh
RUN mkdir -p /run/php
RUN chmod +x /usr/local/bin/auto_config.sh

ENTRYPOINT ["/bin/sh", "/usr/local/bin/auto_config.sh"]

EXPOSE 9000