// sineosc.cpp

#include "stk/FileLoop.h"
#include "stk/FileWvOut.h"
#include <cstdlib>

using namespace stk;

int main()
{
	// Set the global sample rate before creating class instances.
	Stk::setSampleRate( 44100.0 );
	
	int nFrames = 100000;
	FileLoop input;
	FileWvOut output;
	
	try {
	// Load the sine wave file
	input.openFile( "/usr/local/share/stk/rawwaves/sinewave.raw", true );
	
	// Open a 16-bit, one-channel WAV formatted output file
	output.openFile( "hellosine.wav", 1, FileWrite::FILE_WAV, Stk::STK_SINT16 );
	}
	catch ( StkError & ) {
		exit( 1 );
	}

	input.setFrequency( 440.0 );

	// Option 1: Use StkFrames
	/*
	StkFrames frames( nFrames, 1 );
	try {
	  output.tick( input.tick( frames ) );
	}
	catch ( StkError & ) {
	  exit( 1 );
	}
	*/


	// run the oscillator for 40000 samples, writing to the output file
	for ( int i=0; i<40000; i++ ) {
		try {
		output.tick( input.tick() );
		}
		catch ( StkError & ) {
			exit( 1 );
		}
	}
	
	return 0;
}
