#include <stdio.h>
#include <stdlib.h>

int main() {
	int *p = malloc( sizeof(int) );
	*p = 123456789;

	printf( "%d\n", *p );
	
	return 0;
}
