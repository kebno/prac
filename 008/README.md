# Playing with Pipes

Using pipes to practice stream processing in several ways.

Read the descriptions in the source comment headers.

Requires a C compiler and [SoX](http://sox.sourceforge.net).

## Usage
  - simple-passthrough: may be used for any file
    - `cat clip-africa-toto.wav | ./simple-passthrough >> clip.wav`
  - moving-average: pipe in int16_t audio, play as raw wav
    - `cat clip-africa-toto.raw | ./moving-average 30 int16_t | sox -r 22050 -e signed -b 16 -t raw - -d`
  - moving-average-from-files: does what it says
    - see the source comment header
  - test-struct-union
    - Demonstrates type casting by way of a structure/union
`
