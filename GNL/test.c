//
// Created by viodid on 17/02/23.
//

#include "get_next_line.h"

int main(void)
{
    int fd;

    fd = open("/home/viodid/Documents/42-cursus/GNL/test1.txt", O_RDONLY);

    printf("BUFFER_SIZE:%i - fd:%i\n", BUFFER_SIZE, fd);

    printf("%p\n", get_next_line(fd));
    printf("%p\n", get_next_line(fd));
    close(fd);
    system("leaks a.out");
    return (0);
}
