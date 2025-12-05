# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: kaidda-s <kaidda-s@student.42sp.org.br>    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/11/28 15:41:40 by kaidda-s          #+#    #+#              #
#    Updated: 2025/12/01 22:36:49 by kaidda-s         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

CC = cc
CFLAGS = -Wall -Wextra -Werror

LIBFT_DIR = libft
FT_PRINTF_DIR = ft_printf

LIBFT = $(LIBFT_DIR)/libft.a
FT_PRINTF = $(FT_PRINTF_DIR)/libftprintf.a

INCLUDES = -I$(LIBFT_DIR) -I$(FT_PRINTF_DIR) -I.

SERVER = server
CLIENT = client

SERVER_SRC = server.c
CLIENT_SRC = client.c

SERVER_OBJ = $(SERVER_SRC:.c=.o)
CLIENT_OBJ = $(CLIENT_SRC:.c=.o)

all: $(LIBFT) $(SERVER) $(CLIENT)

$(LIBFT):
	@make -C $(LIBFT_DIR)

$(FT_PRINTF):
	@make -C $(FT_PRINTF_DIR)

%.o: %.c
	$(CC) $(CFLAGS) $(INCLUDES) -c $< -o $@

$(SERVER): $(SERVER_OBJ) $(LIBFT) $(FT_PRINTF)
	$(CC) $(CFLAGS) $(SERVER_OBJ) -L$(LIBFT_DIR) -lft -L$(FT_PRINTF_DIR) -lftprintf -o $(SERVER)

$(CLIENT): $(CLIENT_OBJ) $(LIBFT) $(FT_PRINTF)
	$(CC) $(CFLAGS) $(CLIENT_OBJ) -L$(LIBFT_DIR) -lft -L$(FT_PRINTF_DIR) -lftprintf -o $(CLIENT)

clean:
	@make clean -C $(LIBFT_DIR)
	@make clean -C $(FT_PRINTF_DIR)
	rm -f $(SERVER_OBJ) $(CLIENT_OBJ)

fclean: clean
	@make fclean -C $(LIBFT_DIR)
	@make fclean -C $(FT_PRINTF_DIR)
	rm -f $(SERVER) $(CLIENT)

re: fclean all

.PHONY: all clean fclean re
