/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   get_next_line.c                                    :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: dyunta <dyunta@student.42madrid.com>       +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2023/02/10 22:53:22 by dyunta            #+#    #+#             */
/*   Updated: 2023/02/21 15:40:30 by dyunta           ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */
#include "get_next_line.h"

static int	get_buffer_from_read(t_list *header, int fd);
static char	*get_line_output(t_list *node);
static t_list	*rearrange_content(t_list *header);

/* Return one line from the text file pointed to by the file descriptor
 * 1. Read from fd and create a node with the content of the
 * read's buffer and append it to the list.
 * 2. Check whether \n is in the current content, else loop through 1st step.
 * 3. Create a new list with the content of the remaining text after \n.
 * Free the list.
 * 4. Return the content of the desired output*/

char	*get_next_line(int fd)
{
	static	t_list	*header;
	char			*output;

	if (fd < 0 || BUFFER_SIZE < 1 || read(fd, 0, 0) < 0)
	{
		free(header);
		return (NULL);
	}
	if (!header)
	{
		header = (t_list *) malloc(sizeof(t_list));
		header->content = "";
		header->next = NULL;
	}
	if (!get_buffer_from_read(header, fd))
	{
		free_list(header);
		return (NULL);
	}
	output = get_line_output(header);
	header = rearrange_content(header);
	return (output);
}

// O(n^2) where n is the number of nodes in the list
static int	get_buffer_from_read(t_list *header, int fd)
{
	char	*buffer;
	size_t	bytes;

	buffer = (char *) malloc(sizeof(void) * BUFFER_SIZE + 1);
	if (!buffer)
		return (0);
	while (!list_len_check_nl(header, 1))
	{
		bytes = read(fd, buffer, BUFFER_SIZE);
		if (bytes == 0)
			break ;
		buffer[bytes] = '\0';

		if (!create_and_append_node(buffer, header))
		{
			free(buffer);
			return (0);
		}
	}
	free(buffer);
	return (1);
}

// O(n*c) where n is the number of nodes in the list and c is the total number of chars in each node
static char	*get_line_output(t_list *node)
{
	char	*output;
	char	*start_output;
	size_t	i;

    if (!*(node->content) && !node->next)
        return (NULL);
	output = (char *) malloc(sizeof(char) * list_len_check_nl(node, 0) + 1);
	if (!output)
		return (NULL);
	start_output = output;
	while (node)
	{
		i = 0;
		while ((node->content)[i])
		{
            *output++ = (node->content)[i];
			if ((node->content)[i++] == '\n')
				break ;
		}
		node = node->next;
	}
    *output = '\0';
	return (start_output);
}

static t_list	*rearrange_content(t_list *header)
{
	t_list	*node;
	size_t	i;
	t_list	*new_header;

    new_header = NULL;
	node = header;
	while (node)
	{
		i = 0;
		while ((node->content)[i])
		{
            if ((node->content)[i++] == '\n')
                goto endloop;
		}
		node = node->next;
	}
endloop:
	new_header = (t_list *)malloc(sizeof(t_list));
    new_header->next = NULL;
    new_header->content = NULL;
	if (!new_header)
    {
        free_list(header);
        return (NULL);
    }
    if (!node || !*(node->content + i))
    {
        free(new_header);
        free_list(header);
        return (NULL);
    }
    new_header->content = ft_strdup(node->content + i);
	free_list(header);
	return (new_header);
}
