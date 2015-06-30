#include "stk/Noise.h"
using namespace stk;

int main()
{
	StkFrames output(20, 1); // initialize StkFrames to 20 frames and 1 channel, default interleaved)
	Noise noise;

	noise.tick( output );
	for (int i=0; i<output.size(); i++) {
		std::cout << "i = " << i << " : output = " << output[i] << std::endl;
	}

	return 0;
}
