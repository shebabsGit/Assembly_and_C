#include "stdio.h"

// Function prototypes
void byValue(int a);
void byReference(int *a);

int main()
{
	int a = 10;
	int b = a; // Use this value to check if anything happened to value "a"

	printf("Value of a: %d\n", a);

	// Passing num by value
	byValue(a);
	printf("Pass by value a : %d\n", a);

	if(b == a)
	{
		printf("No side effects here\n");
	}
	else
	{
		printf("Something happened to a!\n");
	}

	// Passing num by reference
	byReference(&a);
	printf("Pass by reference a : %d\n", a);

	if (b == a)
	{
		printf("No side effects here\n");
	}
	else
	{
		printf("Something happaned to a!\n");
	}

	return 0;

}


// Function pass by value
void byValue(int a)
{
	a = a * 3;
}


void byReference(int *a)
{
	*a = *a * 3;
}
