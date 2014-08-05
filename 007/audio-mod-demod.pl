$fs = 22500; # sampling frequency
$fc = 6000;  # carrier frequency
$flp = int($fs/2 - $fc); # available bandwidth

open(S,"sox clip-africa-toto.wav -t .raw -r $fs ".
	"-e signed - sinc -$flp |");
open(U,"|sox -b 16 -c 1 -e signed -t .raw -r $fs ".
	"- ssb.wav sinc $fc -n 4096");
 
while(not eof(S)) {
	read(S,$a,2);
	print U pack("s",unpack("s",$a) *
		cos(($n++ * 2 * 3.141592653589793 * $fc) / $fs));
	}
	 
	close(U);
	close(S);

# DEMODULATE 
open(S,"sox ssb.wav -t .raw -e signed -|");
open(U,"|sox -b 16 -c 1 -e signed -t .raw -r $fs ".
	"- demod.wav sinc -$flp -n 4096");
 
while(not eof(S)) {
	read(S,$a,2);
	print U pack("s",unpack("s",$a) *
		cos(($n++ * 2 * 3.141592653589793 * $fc) / $fs));
	}
	 
	close(U);
	close(S);
