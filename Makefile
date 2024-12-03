DOCKER=docker compose
COMPOSE_FILE=./srcs/docker-compose.yml
PROJECT_NAME=inception

# 기본 명령어
build:
	if [ ! -d /home/sihong/data/mariadb_vol ]; then \
		mkdir -p /home/sihong/data/mariadb_vol; \
	fi
	
	if [ ! -d /home/sihong/data/wordpress_vol ]; then \
		mkdir -p /home/sihong/data/wordpress_vol; \
	fi
	$(DOCKER) -p $(PROJECT_NAME) -f $(COMPOSE_FILE) up -d --build
	sleep 5
	docker exec ${PROJECT_NAME}-vsftpd-1 mkdir /var/www/html/wp-content/upgrade
	docker exec ${PROJECT_NAME}-vsftpd-1 /bin/bash -c 'chown -R $${FTPGROUP}:$${FTPUSER} /var/www/html/wp-content/ /var/www/html/wp-content/upgrade'
	docker exec ${PROJECT_NAME}-vsftpd-1 chmod -R 777 /var/www/html/wp-content/ /var/www/html/wp-content/upgrade
up:
	$(DOCKER) -p $(PROJECT_NAME) -f $(COMPOSE_FILE) up -d
	sleep 5
#	docker exec ${PROJECT_NAME}-vsftpd-1 mkdir /var/www/html/wp-content/upgrade
	docker exec ${PROJECT_NAME}-vsftpd-1 /bin/bash -c 'chown -R $${FTPGROUP}:$${FTPUSER} /var/www/html/wp-content/ /var/www/html/wp-content/upgrade'
	docker exec ${PROJECT_NAME}-vsftpd-1 chmod -R 777 /var/www/html/wp-content/ /var/www/html/wp-content/upgrade
down:
	$(DOCKER) -p $(PROJECT_NAME) -f $(COMPOSE_FILE) down

re:
	$(MAKE) down
	$(MAKE) up

clean:
	$(DOCKER) -p $(PROJECT_NAME) -f $(COMPOSE_FILE) down --rmi=all

fclean:
	$(MAKE) clean
	if [ -d /home/sihong/data/mariadb_vol ]; then \
		rm -r /home/sihong/data/mariadb_vol; \
	fi
	if [ -d /home/sihong/data/wordpress_vol ]; then \
		rm -r /home/sihong/data/wordpress_vol; \
	fi
	docker system prune -a --volumes -f

fre:
	$(MAKE) fclean
	$(MAKE) build

ps:
	$(DOCKER) -p $(PROJECT_NAME) -f $(COMPOSE_FILE) ps

#logs:
#	$(DOCKER) -p $(PROJECT_NAME) -f $(COMPOSE_FILE) logs -f