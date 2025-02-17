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
CFLAGS		= -Wall -Werror -Wextra -I$(HEAD) -O3
LDFLAGS		= -L$(LIBFT_DIR) -lft
RM			= rm -rf

SERVER_DIR	= server_src
CLIENT_DIR	= client_src
OBJS_DIR	= obj
BOBJS_DIR	= obj_bonus
LIBFT_DIR	= libft
LIBFT		= $(LIBFT_DIR)/libft.a
HEAD		= inc

SSRCS		= $(wildcard $(SRCS_DIR)/*.c)
CSRCS		= $(wildcard $(SRCS_DIR)/*.c)
# MFILES		=
# BFILES		=
# SRCS		= $(addprefix $(SRCS_DIR)/, $(MFILES))
# BSRCS		= $(addprefix $(BSRCS_DIR)/, $(BFILES))
SOBJS		= $(patsubst $(SERVER_DIR)/%.c, $(OBJS_DIR)/%.o, $(SSRCS))
COBJS		= $(patsubst $(CLIENT_DIR)/%.c, $(OBJS_DIR)/%.o, $(CSRCS))

SERVER		= server
CLIENT		= client

all:		$(SERVER) $(CLIENT)

$(SERVER):	$(SOBJS) $(LIBFT)
			@$(CC) $(OBJS) -o $@ $(LDFLAGS)
			@echo "$(BOLD)$(GREEN)$(SERVER) compiled Successfully$(RESET)"

$(CLIENT): $(COBJS) $(LIBFT)
			@$(CC) $(OBJS) -o $@ $(LDFLAGS)
			@echo "$(BOLD)$(GREEN)$(CLIENT) compiled Successfully$(RESET)"

$(OBJS_DIR)/%.o:		$(SERVER_DIR)/%.c | $(OBJS_DIR)
			@$(CC) $(CFLAGS) -c $< -o $@
			@echo "Compiling $(SERVER) ..."

$(OBJS_DIR)/%.o:		$(CLIENT_DIR)/%.c | $(OBJS_DIR)
			@$(CC) $(CFLAGS) -c $< -o $@
			@echo "Compiling $(CLIENT) ..."

$(OBJS_DIR):
			@mkdir -p $(OBJS_DIR)

$(LIBFT):
			@$(MAKE) all bonus -C $(LIBFT_DIR)

clean:
			@$(RM) $(OBJS_DIR)
			@$(RM) $(BOBJS_DIR)
			@$(MAKE) clean -C $(LIBFT_DIR)
			@echo "Cleaning obj files."

fclean:	
			@echo "Cleaning all files."
			@$(MAKE) clean
			@$(RM) $(NAME)
			@$(RM) $(BNAME)
			@$(MAKE) fclean -C $(LIBFT_DIR)

re:
			@echo "Rebuild $(NAME)"
			@$(MAKE) fclean
			@$(MAKE) all

.PHONY: all clean fclean re bonus
.SECONDARY:	$(OBJS) $(BOBJS) $(LIBFT)
