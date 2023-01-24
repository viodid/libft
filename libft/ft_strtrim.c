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

/* Allocates (with malloc(3)) and returns a copy of
’s1’ with the characters specified in ’set’ removed
from the beginning and the end of the string. */

char *ft_strtrim(char const *s1, char const *set)
{
	char	*ptr;

	char *end = (char *)s1;

	if (!s1)
		return (NULL);
	if (!set)
		return((char *)s1);
	while (ft_strchr(set, (int)*s1))
	{
		s1++;
	}
	while (*end)
		end++;
	while (ft_strrchr(set, (int)*end))
	{
		end--;
	}
	end++;
	size_t	len = 0;
	while (s1 != end--)
	{
		len++;
		if (len > 1000)
			return ("");
	}
	ptr = (char *)malloc(sizeof(char) * len + 1);
	if(!ptr)
		return (NULL);
	char *str_ptr = ptr;
	while (len--)
		*ptr++ = *s1++;
	*ptr = '\0';
	return (str_ptr);
}
