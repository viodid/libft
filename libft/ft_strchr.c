/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   headers.h                                          :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: dyunta <dyunta@student.42.fr>              +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2022/11/21 22:40:09 by dyunta            #+#    #+#             */
/*   Updated: 2022/11/24 12:30:21 by dyunta           ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "libft.h"

/*   Locates the first occurrence of c (converted to a
     char) in the string pointed to by s.  The terminating null character is
     considered part of the string; therefore if c is `\0', the functions
     locate the terminating `\0'.
     The functions strchr() and strrchr() return a pointer to the located
     character, or NULL if the character does not appear in the string.*/

char	*ft_strchr(const char *s, int c)
{
	while (*s != (char)c)
		if (!*s++)
			return (NULL);
	return ((char *)s);
}
