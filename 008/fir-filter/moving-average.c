/*
 * fir_filter00.c
 * John Boyle, ECE506 DSP Applications, Winter 2014, Portland State Univ.
 *
 * An implementation of a FIR filter in C.
 * Usage:
 *   > fir_filter00 <num. coeff> <input.raw> <output.raw>
 *
 * Example invocation:
 *   > fir_filter00 21 sound.pcm sound-filtered.pcm
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define BLOCK_LENGTH 1024

//   * declare variables
char *input_file, *output_file;
FILE *in_fid, *out_fid;
int i, length, ncoeff, nsamp;
float *coeff, *input_f, *insamp_f, *output_f;
int16_t inbuf[ BLOCK_LENGTH ];
int16_t outbuf[ BLOCK_LENGTH ];

//# FUNCTIONS

void print_usage(char *progname)
{
    printf("Usage:\n");
    printf("%s <number of coeff> <input file> <output file>\n", progname);

    printf("\nNOTE: This program expects raw wav files (headerless).\n");
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



int main(int argc, char *argv[])
{   
    char *progname;
    // if progname is called like so: ../../../progname,
    //  then argv[0] would contain all of those forward slashes.
    //  These lines remove them.
	progname = strrchr (argv [0], '/');
	progname = progname ? progname + 1 : argv [0];
    if (argc != 4)
    {	
        print_usage(progname);
        return 1 ;
    } ;

    // get filenames from command prompt
    ncoeff = atoi( argv[1]); 
    input_file = argv[2];
    output_file = argv[3];

    nsamp = get_block_length();

    // allocate arrays
    coeff = (float *)malloc(sizeof(float) * ncoeff);
    input_f = (float *)malloc( sizeof(float) * nsamp);
    insamp_f = (float *)malloc( sizeof(float) * (nsamp+ncoeff));
    output_f = (float *)malloc( sizeof(float) * nsamp);

    // initialize `insamp` with zeros
    for (i=0; i<(nsamp+ncoeff); i++) insamp_f[i] = 0.0f;

    // open input and output files
    in_fid = fopen( input_file, "rb");
    if (in_fid == 0) printf("Couldn't open input file %s\n", input_file);

    out_fid = fopen( output_file, "wb");
    if (out_fid == 0) printf("Couldn't open output file %s\n", output_file);

    // Process audio data
    filter_init(ncoeff);
    do
    {   
        // Get block of data
        length = fread(inbuf, sizeof(int16_t), nsamp, in_fid);
        int_to_float(inbuf, input_f, length);

        filter_block(input_f, output_f, length, coeff, ncoeff);

        // Write out data
        float_to_int(output_f, outbuf, length);
        fwrite(outbuf, sizeof(int16_t), length, out_fid);
    }
    while (length != 0);

    // CLEANUP
    fclose(in_fid);
    fclose(out_fid);

    // release memory of allocated arrays
    free(coeff);
    free(input_f);
    free(insamp_f);
    free(output_f);

    //   * write report message to screen
    printf("File %s was filtered with a moving average filter\n",input_file);
    printf("of %d coefficients and written to %s.\n",ncoeff, output_file);

    return(0);
}
