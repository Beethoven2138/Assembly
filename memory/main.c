#include <stdlib.h>
#include <stdio.h>

extern int init_heap(void);
extern int free_heap(void);
extern int inc_heap(unsigned int amount);

int main(void)
{
        int ret = init_heap();
	if (ret == -1)
	{
		printf("failure");
		exit(-1);
	}
	else
	{
		printf("%d\n", ret);
		printf("%d\n", inc_heap(5));
		printf("%d\n", inc_heap(10));
	}
	return 0;
}


//0x1c == len
//0xc == off
//eax holds len
