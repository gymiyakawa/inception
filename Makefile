
RM = rm -rf
DC = docker compose

IMAGES = $(shell for image in srcs-mariadb srcs-wordpress srcs-nginx; do docker images -q $$image; done)
CONTAINERS = $(shell for container in mariadb wordpress nginx; do docker ps -aq --filter "name=$$container"; done)
VOLUMES = $(shell for volume in srcs_mariadb srcs_wordpress; do docker volume ls --quiet --filter "name=volume"; done)

NETWORK = inception

RM_IMAGES = docker image rm $(IMAGES)
RM_VOL	= docker volume rm -f$(VOLUMES)


# 										<!> USE THIS WHEN RUNNING IN VM <!>
DIR_MDB = /home/gmiyakaw/data/mariadb
DIR_WP = /home/gmiyakaw/data/wordpress

# USE THIS WHEN RUNNING ON MAC
# DIR_MDB = /Users/gmiyakaw/Documents/Common_Core_Projects/inception/srcs/temp_volumes/mariadb
# DIR_WP = /Users/gmiyakaw/Documents/Common_Core_Projects/inception/srcs/temp_volumes/wordpress


SRCS = srcs/docker-compose.yml
OPTIONS = "up --build --remove-orphans -d"


#	command options breakdown:
#	docker compose up -> create and start services listed in Docker Compose file
#	--build -> makes sure anyu images needed are built before running. Rebuilds if any images
#				are outdated or do not exist
#	--remove-orphans -> removes any containers for services defined in the Docker Compose file
#						that are not currently running
#	-d -> runs in detached mode, returning the terminal for further commands

all: docker

docker: $(SRCS)
	@mkdir -p $(DIR_MDB)
	@mkdir -p $(DIR_WP)
	@echo "Volume directories created"
	@$(DC) -f $(SRCS) up --build --remove-orphans -d
	@echo "services build and ready"
	@echo "go to https://gmiyakaw.42.fr to access website"
	@echo "additional useful tips and commands:"
	@echo "if you have connections problems with nginx, make sure wordpress script is done creating the page"
	@echo "to use the terminal of a container you can use 'docker exec -it <container name> /bin/sh' "
	@echo "Use 'mysql -u db_user -p db_name' inside mariadb container to connect to the CLI database"
	@echo "don't forget to add '127.0.0.1 gmiyakaw.42.fr' at the end of the etc/hosts file"

down:
	docker compose -f /srcs/docker-compose.yml down

up:
	docker compose -f /srcs/docker-compose.yml up

clean:
	@$(DC) -f $(SRCS) stop
	@echo "Docker containers stopped"
	
fclean:
	@$(RM) $(DIR_MDB)
	@$(RM) $(DIR_WP)
	@echo "Volume directories removed"
	@$(DC) -f $(SRCS) down
	@echo "Docker Containers removed"
	@if [ -n "$(IMAGES)" ]; then $(RM_IMAGES); echo "Docker Images Removed."; fi
	@if [ -n "$(VOLUMES)" ]; then $(RM_VOL); echo "Docker Volumes Removed."; fi
	
re: fclean all

.PHONY: all clean fclean re docker