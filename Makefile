NAME = inception
COMP_CMD = docker-compose
YML = ./srcs/docker-compose.yml
UP = up
DOWN = down

COMPOSE = $(COMP_CMD) -p $(NAME) -f $(YML)

all :
	$(COMPOSE) $(UP) -d --build

down :
	$(COMPOSE) $(DOWN)

up:
	$(COMPOSE) $(UP) -d

re : fclean all

.PHONY : all down up fclean re
