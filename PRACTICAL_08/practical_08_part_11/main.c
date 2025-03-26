#include "stdio.h"

int main()
{
	int a = 0;
	int loops = 0;

	printf("Enter a number times to loop:");
	scanf("%d", &loops);

	// Switch-case statement example
	switch(loops)
	{
	case 1:
		printf("Loop will run once\n");
		break;
	case 2:
		printf("Loop will run twice\n");
		break;
	case 3:
		printf("Loop will run thrice\n");
		break;
	default:
		printf("Invalid number of loop [%d], try between 1 and 3\n", loops);
		loops = 0;
	}

	if(loops >= 1 && loops <= 3)
	{
		printf("While Loop.......will run [%d] times\n", loops);
		printf("STARTS:\n");
		while(a < loops)
		{
			printf("Loop number %d \n", a);
			a++;
		}
		printf("ENDS:\n\n");
	}

	return 0;
}
