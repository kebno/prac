# 007 Digital Audio Modulation
Simple digital audio modulation.

Code from [windytan's article about voice-over-laser](http://www.windytan.com/2013/02/voice-over-laser.html),
modified to mod and demod in the same script.

## Dependencies
 * sox
 * perl

## Running it
1. `perl audio-mod-demod.pl`

Will create two files, ssb.wav is the single-sideband modulated audio. demod.wav
is the demodulated audio.  clip-africa-toto.wav is the original audio
