# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ybouryal <ybouryal@student.1337.ma>        +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/02/12 14:28:19 by ybouryal          #+#    #+#              #
#    Updated: 2025/02/12 16:05:29 by ybouryal         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# Colors
GREEN		:= $(shell tput -Txterm setaf 2)
BOLD		:= $(shell tput bold);
RESET		:= $(shell tput -Txterm sgr0)

CC			= cc
CFLAGS		= -Wall -Werror -Wextra -I$(HEAD)
LDFLAGS		= -L$(LIBFT_DIR) -lft
RM			= rm -rf

LIBFT_DIR	= libft
LIBFT		= $(LIBFT_DIR)/libft.a

SRCS_DIR	= src
OBJS_DIR	= obj
HEAD		= inc

SSRCS		= src/server.c
BSSRCS		= src/server_bonus.c
CSRCS		= src/client.c
BCSRCS		= src/client_bonus.c
SOBJS		= $(patsubst $(SRCS_DIR)/%.c, $(OBJS_DIR)/%.o, $(SSRCS))
COBJS		= $(patsubst $(SRCS_DIR)/%.c, $(OBJS_DIR)/%.o, $(CSRCS))
BSOBJS		= $(patsubst $(SRCS_DIR)/%.c, $(OBJS_DIR)/%.o, $(BSSRCS))
BCOBJS		= $(patsubst $(SRCS_DIR)/%.c, $(OBJS_DIR)/%.o, $(BCSRCS))

SERVER		= server
BSERVER		= server_bonus
CLIENT		= client
BCLIENT		= client_bonus

all:		$(SERVER) $(CLIENT)

$(SERVER):	$(LIBFT) $(SOBJS) 
			@$(CC) $(SOBJS) -o $@ $(LDFLAGS)
			@echo "$(BOLD)$(GREEN)$(SERVER) compiled Successfully$(RESET)"

$(CLIENT):  $(LIBFT) $(COBJS)
			@$(CC) $(COBJS) -o $@ $(LDFLAGS)
			@echo "$(BOLD)$(GREEN)$(CLIENT) compiled Successfully$(RESET)"

$(SOBJS):	$(SSRCS) | $(OBJS_DIR)
			@$(CC) $(CFLAGS) -c $< -o $@
			@echo "Compiling $(SERVER) ..."

$(COBJS):	$(CSRCS) | $(OBJS_DIR)
			@$(CC) $(CFLAGS) -c $< -o $@
			@echo "Compiling $(CLIENT) ..."

$(OBJS_DIR):
			@mkdir -p $@

bonus:		$(BSERVER) $(BCLIENT)

$(BSERVER):	$(BSOBJS) $(LIBFT)
			@$(CC) $(BSOBJS) -o $@ $(LDFLAGS)
			@echo "$(BOLD)$(GREEN)$(BSERVER) compiled Successfully$(RESET)"

$(BCLIENT):	$(BCOBJS) $(LIBFT)
			@$(CC) $(BCOBJS) -o $@ $(LDFLAGS)
			@echo "$(BOLD)$(GREEN)$(BCLIENT) compiled Successfully$(RESET)"

$(BSOBJS):	$(BSSRCS) | $(OBJS_DIR)
			@$(CC) $(CFLAGS) -c $< -o $@
			@echo "Compiling $(BSERVER) ..."

$(BCOBJS):	$(BCSRCS) | $(OBJS_DIR)
			@$(CC) $(CFLAGS) -c $< -o $@
			@echo "Compiling $(BCLIENT) ..."

$(LIBFT):
			@$(MAKE) all bonus -C $(LIBFT_DIR)

clean:
			@$(RM) $(OBJS_DIR)
			@$(MAKE) clean -C $(LIBFT_DIR)
			@echo "Cleaning obj files."

fclean:	
			@echo "Cleaning all files."
			@$(MAKE) clean
			@$(RM) $(SERVER)
			@$(RM) $(CLIENT)
			@$(RM) $(BSERVER)
			@$(RM) $(BCLIENT)
			@$(MAKE) fclean -C $(LIBFT_DIR)

re:
			@echo "Rebuild $(NAME)"
			@$(MAKE) fclean
			@$(MAKE) all

.PHONY: all clean fclean re bonus
.SECONDARY:	$(SOBJS) $(COBJS) $(LIBFT) $(BSOBJS) $(BCOBJS)
