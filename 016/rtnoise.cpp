#include "stk/Noise.h"
#include "stk/RtWvOut.h"
#include "stk/BiQuad.h"
#include <cstdlib>

using namespace stk;

int main()
{
	Stk::setSampleRate( 44100.0 );
	Stk::showWarnings( true );

	int nFrames = 100000;
	Noise noise;
	RtWvOut *dac = 0;
	BiQuad biquad;
	biquad.setResonance( 440.0, 0.98, true );

	try {
		dac = new RtWvOut( 1 );
	}
	catch (StkError &) {
		exit( 1 );
	}

	for (int i=0; i<nFrames; i++) {
		try {
			dac->tick( biquad.tick( noise.tick() ) );
		}
		catch (StkError & ) {
			goto cleanup;
		}
	}

cleanup:
	delete dac;

	return 0;
}

