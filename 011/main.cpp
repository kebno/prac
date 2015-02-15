#include <iostream>
#include <iomanip>
#include <fstream>
#include <math.h>

#include <gsl/gsl_sf_bessel.h>

int main (void)
{
	double x = 5.0;
	double y = gsl_sf_bessel_J0(x);

	std::cout << "J0(" << x << ") = "
		<< std::setprecision(18) << std::setw(20) << y << std::endl;

	return 0;
}
