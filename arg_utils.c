/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   arg_utils.c                                        :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: dyunta <dyunta@student.42madrid.com>       +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2023/09/28 20:47:39 by dyunta            #+#    #+#             */
/*   Updated: 2023/11/02 21:04:10 by dyunta           ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <push_swap.h>
#include <libft.h>

/*
	Check whether the args in argv are numbers.
	Returns 1 if fails the check.
*/
int	check_num_arg(int argc, char *argv[], int free_argv)
{
	while (--argc >= 0)
	{
		ft_strtol(argv[argc]);
		if (errno != 0 || *argv[argc] == '\0')
		{
			if (free_argv)
				free_argv_func(argv);
			ft_putendl_fd("Error", 2);
			return (1);
		}
	}
	return (0);
}

void	free_argv_func(char **argv)
{
	int	i;

	i = 0;
	while (argv[i])
		free(argv[i++]);
	free(argv);
}

int	check_repeated_arg(t_stack *stack_a, t_stack *stack_b,
	int free_argv, char **argv)
{
	int	*arr;
	int	i;
	int	size;

	size = stack_a->top1 + 1;
	arr = (int *) malloc(sizeof(int) * size);
	i = 0;
	while (i <= stack_a->top1)
	{
		arr[i] = stack_a->p[i];
		i++;
	}
	if (selection_sort(arr, size))
	{
		ft_putendl_fd("Error", 2);
		free(arr);
		free_stacks_argv(stack_a, stack_b, free_argv, argv);
		return (1);
	}
	free(arr);
	return (0);
}

int	selection_sort(int *arr, int size)
{
	int	i;
	int	j;
	int	temp;

	i = 0;
	while (i < size)
	{
		j = i + 1;
		while (j < size)
		{
			if (arr[i] == arr[j])
				return (1);
			if (arr[i] > arr[j])
			{
				temp = arr[i];
				arr[i] = arr[j];
				arr[j] = temp;
			}
			j++;
		}
		i++;
	}
	return (0);
}
