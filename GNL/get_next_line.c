/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   get_next_line.c                                    :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: dyunta <dyunta@student.42madrid.com>       +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2023/02/10 22:53:22 by dyunta            #+#    #+#             */
/*   Updated: 2023/02/15 22:01:45 by dyunta           ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */
#include "get_next_line.h"

int		get_buffer_from_read(t_list *header, int fd);
char	*get_line_output(t_list *node);

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

	header = (t_list *)malloc(sizeof(t_list));
	if (fd < 0 || BUFFER_SIZE < 1 || !header || read(fd, 0, 0) < 0)
	{
		free(header);
		return (NULL);
	}
	header->content = "";
	header->next = NULL;
	if (!get_buffer_from_read(header, fd))
	{
		free_list(header);
		return (NULL);
	}
	output = get_line_output(header);
	if (!output)
	{
		free_list(header);
		return (NULL);
	}
	//header = rearrange_content(header);
	return (output);
}

int	get_buffer_from_read(t_list *header, int fd)
{
	char	*buffer;
	size_t	bytes;

	buffer = (char *) malloc(sizeof(void) * BUFFER_SIZE + 1);
	if (!buffer)
		return (0);
	while (!content_list_len(header))
	{
		bytes = read(fd, buffer, BUFFER_SIZE);
		if (bytes == 0)
			break ;
		buffer[bytes] = '\0';

		if (!append_node(header, create_node(buffer)))
		{
			free(buffer);
			return (0);
		}
	}
	free(buffer);
	return (1);
}

char	*get_line_output(t_list *node)
{
	char	*output;
	char	*start_output;
	size_t	i;

	output = (char *) malloc(sizeof(char) * content_list_len(node));
	if (!output)
		return (NULL);
	start_output = output;
	i = 0;
	while (node)
	{
		while ((node->content)[i])
		{
			if ((node->content)[i] == '\n')
			{
				*output = '\0';
				break ;
			}
			*output = (node->content)[i];
			i++;
			output++;
		}
		node = node->next;
	}
	return (start_output);
}

/*
t_list	*rearrange_content(t_list *header)
{
	t_list	*new_header;
	t_list	*node;

	new_header = (t_list *) malloc(sizeof(t_list));
	if (!new_header)
	{
		free_list(header);
		return (NULL);
	}
	node = header;
	while (node)
	{
		while ((node->content)[i] != '\n')
			i++;
	}
	free_list(header);
	return (new_header);
}
*/
