#include "stk/Iir.h"
using namespace stk;

int main()
{
	StkFrames output( 20, 1 );
	output[0] = 1.0;

	std::vector<StkFloat> numerator( 5, 0.1);
	std::vector<StkFloat> denominator;
	denominator.push_back( 1.0 );
	denominator.push_back( 0.3 );
	denominator.push_back( -0.5 );

	Iir filter( numerator, denominator );

	filter.tick( output );
	for (int i=0; i<output.size(); i++) {
		std::cout << "i = " << i << " : output = " << output[i] << std::endl;
	}
	
	return 0;
}
