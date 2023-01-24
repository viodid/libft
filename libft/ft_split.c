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

/* Allocates (with malloc(3)) and returns an array
of strings obtained by splitting ’s’ using the
character ’c’ as a delimiter. The array must end
with a NULL pointer. */

static size_t	get_different_strs(char const *s, char c);
static const char	*get_str_till_c(char const *s, char c, char **ptr);

char **ft_split(char const *s, char c)
{
	char	**ptr;
	size_t	different_strs;

	printf("s: %s - c: %c, ", s, c);

	if (!s || !*s)	
		return (NULL);

	different_strs = get_different_strs(s, c);

	ptr = (char **)malloc(sizeof(char *) * different_strs);
	if (!ptr)
		return (NULL);
	while (different_strs--)
		ptr[different_strs] = NULL;


	// get string till c or end of string
	s = get_str_till_c(s, c, ptr);
	while (*s++)
		s = get_str_till_c(s, c, ptr);

	return (ptr);
}

static size_t	get_len_till_c(char const *s, char c)
{
	size_t	len;

	len = 0;
	while (*s && *s++ != c)
		len++;
	return (len);
}

static size_t	get_different_strs(char const *s, char c)
{
	size_t	different_strs;
	size_t	i;

	different_strs = 0;
	i = 0;
	while (s[i])
	{
		if (s[i] == c && i != 0 && s[i + 1] != '\0' && s[i - 1] != c
			&& s[i + 1] != c)
			different_strs++;
		i++;
	}
	return (different_strs + 1);
}

static const char	*get_str_till_c(char const *s, char c, char **ptr)
{
	size_t	i;
	size_t	len;
	size_t	j;

	if (!s)
		return (NULL);
	i = 0;
	while (ptr[i])
		i++;

	len = get_len_till_c(s, c);
	ptr[i] = (char *)malloc(sizeof(char) * len + 1);
	if (!ptr[i])
		return (NULL);

	j = 0;
	while (*s != c && *s)
	{
		ptr[i][j++] = *s++;
	}
	ptr[i][j] = '\0';
	return (s);
}

/*
int	main(void)
{
	char **output = ft_split("nopehnope", 'h');
	printf("%s - %s\n", output[0], output[1]);
	return (0);
}
*/
