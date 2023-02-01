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

static int last_char_index(const char *s1);

/* Allocates (with malloc(3)) and returns a copy of
’s1’ with the characters specified in ’set’ removed
from the beginning and the end of the string. */

char *ft_strtrim(char const *s1, char const *set)
{
    char    *aux;
    int     last_index_s1;
    int     i;
    int     j;

    // Protect the function
    if (!s1)
        return (NULL);
    if (!set)
        return (ft_strdup(s1));
    // Allocate and copy s1 to a new string
    // Iterate through ptr finding coincidences with set in sequential order
    // if set reaches '\0', remove from ptr, else, restart ptr with previous values
    i = 0;
    aux = ft_strchr(s1, (int)set[i]);
    while (aux == &s1[i])
    {
        i++;
        aux = ft_strchr((const char *)&s1[i], (int)set[i]);
    }
    last_index_s1 = (int)ft_strlen(s1) - 1;
    // Restart i whenever the comparation fail, else set i as trimmed string start index
    if (set[i])
        i = 0;
    j = 0;
    // Compare from the end of the strings
    aux = ft_strrchr(&s1[last_index_s1], (int)set[last_char_index(set)]);
    while (aux == &s1[last_index_s1 - j])
    {
        j++;
        aux = ft_strrchr(&s1[last_index_s1 - j],
                         (int)set[last_char_index(set) -j]);
    }
    // Restart j whenever the comparation fails, else set j as trimmed string end index
    if (set[0] != set[last_char_index(set) - j + 1])
        j = 0;
    size_t total_length = last_index_s1 - i - j + 1;
    char *ptr = (char *)malloc(sizeof(char) * total_length + 1);
    return (ft_memcpy(ptr, &s1[i], total_length));
}

static int last_char_index(const char *s1)
{
    int i;

    i = 0;
    while (s1[i])
        i++;
    return (--i);
}