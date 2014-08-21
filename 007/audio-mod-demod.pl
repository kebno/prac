$input_audio = "clip-africa-toto.wav";
$mod_audio = "ssb.wav";
$demod_audio = "demod.wav";

$fs = 22500; # sampling frequency
$fc = 6000;  # carrier frequency
$flp = int($fs/2 - $fc); # available bandwidth

open(S,"sox $input_audio -t .raw -r $fs ".
	"-e signed - sinc -$flp |");
open(U,"|sox -b 16 -c 1 -e signed -t .raw -r $fs ".
	"- $mod_audio sinc $fc -n 4096");
 
while(not eof(S)) {
	read(S,$a,2);
	print U pack("s",unpack("s",$a) *
		cos(($n++ * 2 * 3.141592653589793 * $fc) / $fs));
	}
	 
	close(U);
	close(S);

# DEMODULATE 
open(S,"sox $mod_audio -t .raw -e signed -|");
open(U,"|sox -b 16 -c 1 -e signed -t .raw -r $fs ".
	"- $demod_audio sinc -$flp -n 4096");
 
while(not eof(S)) {
	read(S,$a,2);
	print U pack("s",unpack("s",$a) *
		cos(($n++ * 2 * 3.141592653589793 * $fc) / $fs));
	}
	 
	close(U);
	close(S);
