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

static int	check_substring(const char *big, const char *little, size_t len);

char	*ft_strnstr(const char *big, const char *little, size_t len)
{
	if (!*little)
		return ((char *)big);
	while (len-- && *big)
	{
		if (*big == *little)
		{
			if (check_substring(big, little, len + 1))
				return ((char *)big);
		}
		big++;
	}
	return (0);
}

static int	check_substring(const char *big, const char *little, size_t len)
{
	while (len-- && *little)
	{
		if (*little++ != *big++)
			return (0);
	}
	if (*little)
		return (0);
	return (1);
}
