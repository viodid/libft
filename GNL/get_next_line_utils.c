/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   get_next_line_utils.c                              :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: dyunta <dyunta@student.42madrid.com>       +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2023/02/10 22:53:31 by dyunta            #+#    #+#             */
/*   Updated: 2023/02/19 19:19:43 by dyunta           ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "get_next_line.h"

size_t	list_len_check_nl(t_list *node, int check)
{
	size_t	len;
	size_t	i;

	if (!node)
		return (0);
	len = 0;
	while (node)
	{
		i = 0;
		while ((node->content)[i])
		{
			len++;
			if ((node->content)[i++] == '\n')
				return (len);
		}
		node = node->next;
	}
	if (!check)
		return (len);
	return (0);
}

t_list	*create_and_append_node(char *buffer, t_list *header)
{
	t_list	*node;
	t_list	*tmp;

	if (!buffer)
		return (NULL);
	node = (t_list *) malloc(sizeof(t_list));
	if (!node)
		return (NULL);
	node->content = ft_strdup((const char *)buffer);
	if (!node->content)
		return (NULL);
	node->next = NULL;
	if (!header)
		return (node);
	tmp = header;
	while (tmp->next)
		tmp = tmp->next;
	tmp->next = node;
	return (header);
}

/* Linked list error proof free function */
void	free_list(t_list *node)
{
	if (!node)
		return ;
	free_list(node->next);
	if (*(node->content))
		free(node->content);
	free(node);
}

char	*ft_strdup(const char *str)
{
	int		len;
	char	*ptr;
	char	*start_ptr;

	if (!str)
		return (NULL);
	len = 0;
	while (*str && str[len])
		len++;
	ptr = (char *)malloc(len + 1);
	if (!ptr)
		return (NULL);
	start_ptr = ptr;
	while (*str)
		*ptr++ = *(char *)str++;
	*ptr = '\0';
	return (start_ptr);
}
