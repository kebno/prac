/* PASSTHROUGH.C
 *  Aug 2014, John Boyle
 *
 *  Reads from stdin and writes it to stdout.
 *
 *  Based on tutorial at http://mishotips.blogspot.com/2013/05/redirecting-standard-input-and-output.html
 */

#include <stdio.h>
#include <string.h>

//# FUNCTIONS

void print_usage(char *progname)
{
    printf("usage: %s <data_type>\n\n", progname);
    printf("   <data_type> is one of the following:  \n"
		   "       int8_t  int16_t  float\n\n");
}


int
main(int argc, char *argv[])
{
	char *progname;
	// if progname is called like so: ../../../progname,
	// then argv[0] would contain all of those forward slashes.
	// This code removes them.
	progname = strrchr (argv[0], '/');
	progname = progname ? progname + 1 : argv[0];
	if (argc != 2)
	{
		print_usage(progname);
		return 1;
	}

	char *data_type = argv[1];
	printf("%s is the <data_type> you entered.\n", data_type);

	int c;
	while ((c = getchar()) != EOF)
		putchar(c);
	
	return 0;
}
