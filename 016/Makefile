# Explanation of the "Automatic Variables"
#   $^ names of all prerequisites, with spaces between them
#   $@ the file name of the target of the rule
CC       = g++
DEFS     =   -DHAVE_GETTIMEOFDAY  -D__MACOSX_CORE__
DEFS    += -D__LITTLE_ENDIAN__
CFLAGS   = -O3 -Wall
LIBRARY = -lstk -lpthread -lm  -framework CoreAudio -framework CoreFoundation -framework CoreMidi

# TARGETS
example_programs := $(patsubst %.cpp, %, $(wildcard *.cpp))
	
all: $(example_programs)

# This means that each program depends on a file with 
# the same name but with ".c" appended
% : %.cpp
	$(CC) $(CFLAGS) $^ -o $@ $(LIBRARY)

clean:
	rm -f $(example_programs) hellosine.wav
