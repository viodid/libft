.PHONY = all clean fclean re

CC := gcc

LINKERFLAG = -g -Wall -Wextra -Werror

NAME = gnl.a

SRCS := get_next_line.c \
	get_next_line_utils.c

OBJS := $(SRCS:.c=.o)

$(NAME): $(OBJS)
	ar -ruv $(NAME) $(OBJS)

all: $(NAME)

clean:
	rm -f $(OBJS)

fclean: clean
	rm -f $(NAME)

re: fclean all