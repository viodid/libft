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

/* Allocates (with malloc(3)) and returns an array
of strings obtained by splitting ’s’ using the
character ’c’ as a delimiter. The array must end
with a NULL pointer. */

static int	count_different_substr(char const *s, char c);
static char	**get_strs(char const *s, char c, char **ptr);

char	**ft_split(char const *s, char c)
{
	char	**ptr;
	int		different_strs;

	if (!s)
		return (NULL);
	different_strs = count_different_substr(s, c);
	ptr = (char **)malloc(sizeof(char *) * different_strs);
	if (!ptr)
		return (NULL);
	while (different_strs--)
		ptr[different_strs] = NULL;
	return (get_strs(s, c, ptr));
}

static int	count_different_substr(char const *s, char c)
{
	int	different_strs;
	int	i;
	int	j;
	int	len;

	different_strs = 0;
	i = 0;
	len = (int)ft_strlen(s);
	while (i < len)
	{
		while ((int)s[i] == (int)c && s[i])
			i++;
		j = i;
		while ((int)s[i] != (int)c && s[i])
			i++;
		if (j < i)
			different_strs++;
	}
	return (different_strs);
}

static int	alloc_from_buffer(char *buffer, char **ptr, int index)
{
	ptr[index] = (char *) malloc(sizeof(char)
			* ft_strlen(buffer) + 1);
	if (!ptr[index])
		return (1);
	ft_strlcpy(ptr[index], (const char *)buffer,
		ft_strlen(buffer) + 1);
	return (0);
}

static char	**get_strs(char const *s, char c, char **ptr)
{
	int		substr_index;
	char	buffer[256];
	int		i;
	int		j;

	substr_index = 0;
	i = 0;
	while (i < (int)ft_strlen(s))
	{
		j = 0;
		while ((int)s[i] == (int)c && s[i])
			i++;
		if (!s[i])
			break ;
		while ((int)s[i] != c && s[i])
			buffer[j++] = s[i++];
		buffer[j] = '\0';
		if (alloc_from_buffer(buffer, ptr, substr_index))
			return (NULL);
		substr_index++;
	}
	return (ptr);
}
