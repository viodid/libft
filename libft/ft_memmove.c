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

// https://stackoverflow.com/questions/20725573/what-is-overlapping-in-memmove-definition
// https://aticleworld.com/memmove-function-implementation-in-c/

typedef unsigned long long size_t;

void *ft_memmove(void *dst, const void *src, size_t len)
{
	if (!dst && !src)
		return (dst);
	char *ptr;

	ptr = dst;
	if (src < dst)
	{
		while (len--)
			*(ptr + len) = *((char *)src + len);
	}
	else
	{
		while (len--)
			*ptr++ = *(char *)src++;
	}
	return (dst);
}
