//
// Created by viodid on 17/02/23.
//

#include "get_next_line.h"

int main(void)
{
	int fd;

	fd = open("/Users/dyunta/Documents/42_github_repo/GNL/test1.txt", O_RDONLY);

	printf("BUFFER_SIZE:%i - fd:%i\n", BUFFER_SIZE, fd);

	printf("%s\n", get_next_line(fd));
	printf("%s\n", get_next_line(fd));
	close(fd);
	system("leaks GNL");
	return (0);
}
