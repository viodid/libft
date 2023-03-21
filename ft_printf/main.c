#include "include/ft_printf.h"
#include "include/libft.h"

int main()
{
  int i = ft_printf("hey there!");
  ft_printf("%d",i);
  int j = printf("hey there!");
  printf("%d",j);
  return (0);
}
