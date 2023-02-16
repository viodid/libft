/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   get_next_line_utils.c                              :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: dyunta <dyunta@student.42madrid.com>       +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2023/02/10 22:53:31 by dyunta            #+#    #+#             */
/*   Updated: 2023/02/15 20:22:04 by dyunta           ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "get_next_line.h"

size_t	content_list_len(t_list *node)
{
	size_t	len;
	size_t	i;

	len = 0;
	i = 0;
	while (node)
	{
		while ((node->content)[i])
		{
			if ((node->content)[i] == '\n')
				return (len);
			len++;
			i++;
		}
		node = node->next;
	}
	return (0);
}

// TODO
// Allocate and assign buffer to content
t_list	*create_node(char *content)
{
	t_list	*node;

	node = (t_list *) malloc(sizeof(t_list));
	if (!node)
		return (NULL);
	node->content = content;
	node->next = NULL;
	return (node);
}

int	append_node(t_list *header, t_list *node)
{
	if (!node)
		return (0);
	while (header->next)
		header = header->next;
	header->next = node;
	return (1);
}

void	free_list(t_list *node)
{
	if (!node)
		return ;
	free_list(node->next);
	free(node->content);
	free(node);
}
