NAME = inception
COMP_CMD = docker-compose
YML = ./srcs/docker-compose.yml
UP = up
DOWN = down
DB_VOL_DATA = /home/yjung/data/db_vol
WP_VOL_DATA = /home/yjung/data/wp_vol
COMPOSE = $(COMP_CMD) -p $(NAME) -f $(YML)

all :
	mkdir /home/yjung/data
	mkdir $(DB_VOL_DATA) $(WP_VOL_DATA)
	$(COMPOSE) $(UP) -d --build

down :
	$(COMPOSE) $(DOWN)

up:
	$(COMPOSE) $(UP) -d

fclean :
	$(COMPOSE) $(DOWN) --rmi all --volumes
	rm -rf /home/yjung/data
	rm -rf $(DB_VOL_DATA) $(WP_VOL_DATA)

re : fclean all

.PHONY : all down up fclean re
