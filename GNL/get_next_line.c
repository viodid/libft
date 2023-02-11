/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   get_next_line.c                                    :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: dyunta <dyunta@student.42madrid.com>       +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2023/02/10 22:53:22 by dyunta            #+#    #+#             */
/*   Updated: 2023/02/11 03:53:14 by dyunta           ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */
#include "get_next_line.h"

char	*allocate_and_return_content(t_list *header, int fd);
int	check_new_line(t_list *node);

/* Return one line from the text file pointed to by the file descriptor
 * 1. Read from fd and create a node with the content of the
 * read's buffer and append it to the list.
 * 2. Check whether \n is in the current content, else loop through 1st step.
 * 3. Create a new list with the content of the remaining text after \n.
 * Free the list.
 * 4. Return the content of the desired output*/

char	*get_next_line(int fd)
{
	static t_list	*header;

	if (fd < 0 || BUFFER_SIZE < 1)
	{
		free(header);
		return (NULL);
	}
	return (allocate_and_return_content(header, fd));
}

char	*allocate_and_return_content(t_list *header, int fd)
{
	char	*buffer;
	char	*output;
	size_t	bytes;

	buffer = (char *) malloc(sizeof(void) * BUFFER_SIZE + 1);
	if (!buffer)
		return (NULL);
	bytes = read(fd, buffer, BUFFER_SIZE);
	while (!check_new_line(header) || bytes != 0)
	{
		if (!append_node(header, create_node(buffer)))
		{
			free(buffer);
			return (NULL);
		}
		bytes = read(fd, buffer, BUFFER_SIZE);
		buffer[bytes] = '\0';
	}
	output = get_line_from_struct(header);
	rearrange_content(header);
	free_list(header);
	free(buffer);
	return (output);
}

int	check_new_line(t_list *node)
{
	while (node)
	{
		if (ft_strchr(node->content, '\n'))
			return (1);
		node = node->next;
	}
	return (0);
}
