.PHONY = all clean fclean re

CC := gcc

LINKERFLAG = -g -Wall -Wextra -Werror

NAME = gnl.a

SRCS := get_next_line_utils.c \
	get_next_line.c \
	test.c

OBJS := $(SRCS:.c=.o)

$(NAME): $(OBJS)
	ar -ruv $(NAME) $(OBJS)

all: $(NAME)
	$(CC) $(LINKERFLAG) -o test $(NAME)

clean:
	rm -f $(OBJS)

fclean: clean
	rm -f $(NAME)

re: fclean all