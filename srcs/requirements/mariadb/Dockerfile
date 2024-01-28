# Fields left blank or commented  = need researching

		#Docker will read this and know to pull Debian:buster from Dockerhub upon running Docker build
FROM debian:buster

	#Docker will run this when building the image. THis installs mariadb-server
RUN apt-get update -y && apt-get install mariadb-server -y

	#copies from our local files into the Docker image.
	#in this case, we're copying the configuration files into the correct folder for mariadb
	#50-server: 50 is a convetion. The prefix is used to tell which conf files to load, as they
	#are loaded lexicographically.
COPY ./tools/50-server.cnf /etc/mysql/mariadb.conf.d/


COPY ./tools/script.sh /

CMD ["/script.sh"]