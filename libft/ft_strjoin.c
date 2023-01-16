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

#include <stdlib.h>

char *ft_substr(char const *s, unsigned int start, size_t len)
{
	char	*ptr;
	char	*start_ptr;

	ptr = (char *)malloc(sizeof(char) * len + 1);
	start_ptr = ptr;
	if (!ptr)
		return (NULL);
	s += start;
	while (len--)
		*ptr++ = *(char *)s++;
	*++ptr = '\0';
	return (start_ptr);
}
