#include "stdio.h"

// Function declaration
int add(int, int);

int main()
{
	int result;

	// Calling add function
	result = add(3, 4);

	// Display result
	printf("Result : %d\n", result);

	return 0;
}

// Function Definition
int add(int a, int b)
{
	return a + b;
}
