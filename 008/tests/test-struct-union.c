/* Demonstrate and test anonymous unions in structs.
 *
 * Run this and you will see how printing each union member causes
 * a different cast of memory contents.
 *
 * Useful for reading in one format and converting or changing to another,
 * such as reading from stdin with "getchar()" and using two of them
 * as an int16_t audio sample.  Then, after manipulating the sample, you
 * may use "putchar()" on the two bytes of the sample without any difficult
 * type casting.
 *
 * Aug 2014, John K. Boyle
 */

#include <stdio.h>
#include <stdlib.h>

int main(void)
{
	typedef struct { 
	size_t nbytes;
	union 
		{
			char buf_char[4];
			int16_t buf_16t;
			int8_t  buf_8t[2];
			float   buf_f;
		};
	} data_sample;
	
	data_sample samp = {2, {"????"}};

	//samp.buf_8t[0] = (int8_t)94;
	//samp.buf_8t[1] = (int8_t)94;
	samp.buf_16t = 24158;

	printf("Char: ...%s...\n", samp.buf_char);
	printf("16t: %d\n", samp.buf_16t);
	printf("8t: %d %d \n", samp.buf_8t[0], samp.buf_8t[1]);
	printf("float: %f\n", samp.buf_f);
	
	return 0;
}
