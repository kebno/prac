#include "stk/BiQuad.h"
#include "stk/Noise.h"

using namespace stk;

int main()
{
	StkFrames output( 20, 1 );
	Noise noise;

	BiQuad biquad;
	biquad.setResonance( 440.0, 0.98, true );

	biquad.tick( noise.tick( output ) );
	for (int i=0; i<output.size(); i++ ) {
		std::cout << "i = " << i << " : output = " << output[i] << std::endl;
	}

	return 0;
}
