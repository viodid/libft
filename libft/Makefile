LIB = ar rcs

NAME = libft.a

MY_SOURCES = ft_isalpha.c \
			 			ft_isdigit.c  \
						ft_isalnum.c \
						ft_strchr.c \
						ft_isascii.c \
						ft_isprint.c \
						ft_strlen.c \
						ft_memset.c \
						ft_bzero.c \
						ft_memcpy.c \
						ft_memmove.c \
						ft_substr.c \
						ft_strlcpy.c \
						ft_strlcat.c \
						ft_tolower.c \
						ft_toupper.c \
						ft_strrchr.c \
						ft_strncmp.c \
						ft_memchr.c \
						ft_memcmp.c \

MY_OBJECTS = $(MY_SOURCES:.c=.o)

CFLAGS += -Wall -Wextra -Werror

$(NAME): $(MY_OBJECTS) libft.h
			$(LIB) $(NAME) $(MY_OBJECTS)

%.o: %.c
	gcc $(CFLAGS) -c -o $@ $<

clean:
			rm -f *.o
fclean:
			rm -f $(NAME)
