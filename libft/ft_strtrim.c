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

/* Allocates (with malloc(3)) and returns a copy of
’s1’ with the characters specified in ’set’ removed
from the beginning and the end of the string. */

char    *ft_strtrim(char const *s1, char const *set)
{
    char    *ptr;
    int     i;
    int     j;

    // Protect the function
    if (!s1)
        return (NULL);
    if (!set)
        return (ft_strdup(s1));
    // Find set into s1
    i = 0;
    while (ft_strchr(set, (int)s1[i]) && s1[i])
        i++;
    // Return empty string whether s1 only contains trim characters o s1 is empty
    if (i >= (int)ft_strlen(s1))
        return (ft_strdup(""));
    j = (int)ft_strlen(s1);
    while (ft_strchr(set, (int)s1[j]))
        j--;
    ptr = (char *)malloc(sizeof(char) * j - i + 2);
    if (!ptr)
        return (NULL);
    ft_strlcpy(ptr, &s1[i], j - i + 2);
    return (ptr);
}