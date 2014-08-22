/* PASSTHROUGH.C
 *  Aug 2014, John Boyle
 *
 *  Reads from stdin and writes it to stdout.
 *
 *  Based on tutorial at http://mishotips.blogspot.com/2013/05/redirecting-standard-input-and-output.html
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>

#define BLOCK_LENGTH 1

int i, length, ncoeff, nsamp;
float *coeff, *input_f, *insamp_f, *output_f;
int16_t inbuf[ BLOCK_LENGTH ];
int16_t outbuf[ BLOCK_LENGTH ];

typedef struct { 
	size_t nbytes;
	union 
	{
		char buf_char[4];
		int16_t buf_16t[1];
		int8_t  buf_8t[2];
		float   buf_f[1];
	};
} data_sample;
					 
//# FUNCTIONS

void print_usage(char *progname)
{
    printf("usage: %s <data_type>\n\n", progname);
    printf("   <data_type> is one of the following:  \n"
		   "       int8_t  int16_t  float\n\n"
		   "   int16_t is the default value. \n\n");
}

int read_sample(data_sample *samp)
{
	int n=0;

	for (n=0; n < samp->nbytes; n++)
		if ((samp->buf_char[n] = getchar()) == EOF)
			return 1;
	
	return 0;
}

int write_sample(data_sample *samp)
{
	int n=0;

	for (n=0; n < samp->nbytes; n++)
		putchar(samp->buf_char[n]);
	
	return 0;
}


//### get_block_length - in libece486
int get_block_length(void)
{
    int foo = BLOCK_LENGTH;
    return(foo);
}

//### Calculate Moving Average filter coefficients
void filter_init(int N)
{
    int i;
    for (i=0; i!=N; i++) coeff[i] = 1.0f/ (float)N; 
}

//### Int16 to float
void int_to_float(int16_t *input, float *output, int length)
{
    int i;
    for (i=0; i<length; i++) output[i] = (float)input[i];
}

//### Filter block
void 
filter_block(float *input, float *output, int length, float *coeff, int ncoeff)
{
    float acc;
    int m, n;

    // Copy new samples to upper end of insamp array
    memcpy(&insamp_f[ncoeff-1], input, sizeof(float)*length);
    
    for (m=0; m<length; m++)
    {
        acc = 0.0f;
        for (n=0; n<ncoeff; n++)
        {
            acc += coeff[n]*insamp_f[m+n];
        }
        output[m] = acc;
    }

    // Copy the latest (ncoeff-1) samples to start of array for next cycle 
    memmove(&insamp_f[0], &insamp_f[length], sizeof(float)*(ncoeff-1));
}

//### Float to int16
void float_to_int(float *input, int16_t *output, int length)
{
    int cur_val;

    for (i=0; i!=length; i++)
    {
        cur_val = input[i];
        if (cur_val > 32767.0) cur_val = 32767.0;
        if (cur_val < -32768.0) cur_val = -32768.0;
        output[i] = (int16_t)cur_val;
    }
}



/////////////////////////////////////////
int
main(int argc, char *argv[])
{
	char *progname;

	// if progname is called like so: ../../../progname,
	// then argv[0] would contain all of those forward slashes.
	// This code removes them.
	progname = strrchr (argv[0], '/');
	progname = progname ? progname + 1 : argv[0];
	if (argc != 3)
	{
		print_usage(progname);
		return 1;
	}
	
	// Process command line arguement
	ncoeff = atoi(argv[1]);
	if (ncoeff > 1024 || ncoeff < 2){ printf("%d is a Bad coefficient number.\n",ncoeff); return 1;}
	
	char *data_type;
	strncpy(data_type,argv[2],10);

	size_t nbytes;
    if (strcmp(data_type,"int8_t")==0)
		nbytes = sizeof(int8_t); 
	else if (strcmp(data_type,"int16_t")==0)
		nbytes = sizeof(int16_t);
	else if (strcmp(data_type,"float")==0)
		nbytes = sizeof(float);
	else {
			printf("ERROR: %s is the <data_type> you entered.\n", data_type);
			printf("Not an accepted data_type\n"); 
			return 1;}
	if (nbytes != 2)
	{ printf("Only 16 bit audio for now!"); return 1;}

	// allocate arrays
	nsamp = get_block_length();
	coeff = (float *)malloc(sizeof(float) * ncoeff);
    input_f = (float *)malloc( sizeof(float) * nsamp);
    insamp_f = (float *)malloc( sizeof(float) * (nsamp+ncoeff));
    output_f = (float *)malloc( sizeof(float) * nsamp);

    // initialize `insamp` with zeros (used in filter_block)
    for (i=0; i<(nsamp+ncoeff); i++) insamp_f[i] = 0.0f;

	filter_init(ncoeff);

	// Setup sample for storing data
	data_sample sample = {nbytes, {"????"}};
	data_sample *sptr = &sample;
	
	// Process stream
	while(!(read_sample(sptr)))
		int_to_float((int16_t*)(sptr->buf_16t),input_f,1);
		filter_block(input_f, output_f, 1, coeff, ncoeff);

		// Write out data
		float_to_int(output_f, outbuf, 1);
		*sample.buf_16t = *outbuf;
		write_sample(sptr);

	return 0;
}

