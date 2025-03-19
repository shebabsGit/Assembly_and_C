#include "stdio.h"

int main()
{
    int a; // a == 0

    // Call to printf function a is substituted for %d
    printf("Value of a is %d\n", a);

    // Scope 1
    {
        a = 10; // a == 10
        printf("Value of a is %d\n", a);
    }

    // Scope 2
    {
        a = 100; // a == 100
        printf("Value of a is %d\n", a);
    }

    printf("Value of a is %d\n", a); // a == 100
    return 0;
}