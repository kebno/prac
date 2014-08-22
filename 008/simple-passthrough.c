/*  simple-passthrough.c 
 *  Aug 2014, John Boyle
 *
 *  Reads from stdin and writes it to stdout.
 *
 *  From tutorial at http://mishotips.blogspot.com/2013/05/redirecting-standard-input-and-output.html
 */

#include <stdio.h>
int
main()
{
	int c;
	while ((c = getchar()) != EOF)
		putchar(c);
	
	return 0;
}
