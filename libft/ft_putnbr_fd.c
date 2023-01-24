/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_isalpha.c                                       :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: dyunta <marvin@42.fr>                      +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2023/01/10 16:50:49 by dyunta            #+#    #+#             */
/*   Updated: 2023/01/10 16:51:31 by dyunta           ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "libft.h"

#include <stdio.h>
#include <stdlib.h>

/* Outputs the integer ’n’ to the given file
descriptor. */

void ft_putnbr_fd(int n, int fd)
{
	char *nbr = ft_itoa(n);
	ft_putstr_fd(nbr, fd);
	free((void *)nbr);
}

int main()
{
	ft_putnbr_fd(2147483647, 1);
	return 0;
}
