#include "stdio.h"

extern int add(int a, int b, int c);

int main(int argc, char **argv)
{
  printf("%d\n", add(4, 6, 8));
  return 0;
}
