#include <stdlib.h>
#include <stdio.h>

#define LEN 5

/*void sort(int *nums, int len)
{
	--len;
	int off = 0;
        while (off < len - 1)
	{
		for (int i = len; i > off; --i)
		{
			if (nums[i-1] > nums[i])
			{
				int old = nums[i];
				nums[i] = nums[i-1];
				nums[i-1] = old;
			}
		}
		++off;
	}
	}*/

extern void _sort(int *num, int len);

int main(void)
{
	int nums[LEN] = {60,4,24,7,10};

	_sort(nums, LEN);

	return 0;
}


//0x1c == len
//0xc == off
//eax holds len
