//
// Created by viodid on 17/02/23.
//

#include "get_next_line.h"

int main(int argc, char **argv)
{
	int fd;

    printf("%s - %i\n", argv[1], argc);

	fd = open("/home/viodid/Documents/42-cursus/GNL/test4.txt", O_RDONLY);

	printf("BUFFER_SIZE:%i - fd:%i\n", BUFFER_SIZE, fd);

	printf("%s\n", get_next_line(fd));
	printf("%s\n", get_next_line(fd));
	close(fd);
	system("leaks GNL");
	return (0);
}
