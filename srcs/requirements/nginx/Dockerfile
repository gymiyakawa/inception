
FROM debian:bullseye


#######		INSTALLING NECESSARY PACKAGES
ENV PACKS="nginx vim curl"

RUN apt update \
    && apt upgrade -y \
    && apt install -y $PACKS

######		CREATING SSL CERTIFICATE

RUN mkdir -p /etc/nginx/certs


#				OPENSSL OPTIONS BREAKDOWN:
#	-x509 - Specifies the X.509 certificate format (self-signed).
#	-nodes - Specifies no DES(Data Encryption Standard) encryption for private key
#			means it won't require a password, making automated processes easier
#	-days 365 - certificate is valid for one year
#	-newkey rsa:2048 - generates a new RSA private key, the keysize is 2048 bits
#				RSA - Rivest-Shamir-Adleman is a widely used public-key criptosystem
#	-keyout - specifies the outputfile for the key
#	-out - specifies the outputfile for the certificate
#	-subj - specifies the subject of the certificate. Used to prefil information
#			in this case: country (C), state (ST), location (L), organization (O), 
#			organizational unit (OU), common name (CN), and user ID (UID)

RUN	openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
	-keyout /etc/nginx/certs/selfsigned.key \
	-out /etc/nginx/certs/selfsigned.crt \
	-subj "/C=CA/ST=QC/L=Quebec/O=42QC/CN=gmiyakaw.42.fr/UID=gmiyakaw"


######		CONFIGURATION

RUN	mkdir -p /var/run/nginx

#	copies the configuration file stored locally into the docker image
COPY conf/nginx.conf /etc/nginx/nginx.conf


#	chmod(change mode) breakdown:
#		7 for the owner (rwx or read, write, and execute permissions).
#		5 for the group (r-x or read and execute permissions).
#		5 for others (r-x or read and execute permissions).

#	chwon(change owner) breakdown:
#	- R - means it's recursive, it will repeat for all files and folders

#	www-data:www-data = (USER=www-data):(GROUP=www-data)

#	USER=www-data is set as owner. This is commonly done in webserver to make
#	sure the server has the necessary permissions to serve or create files,
#	among other necessary operations

#	GROUP=www-data - this specifies the group that will be set for the directory
#	or file. Again, this is commonly done in webservers to ensure it has the
#	necessary permissions to execute it's operations

RUN chmod 755 /var/www/html \ 
	&& chwon -R www-data:www-data /var/www/html


#	copies the bash script from the local tools folder into the image's root directory
COPY ./tools/script.sh /

CMD ["/script.sh"]