CC=cc
CFLAGS=-Wall -g -O2 -I/Users/john/sw/include
LDFLAGS+=-L/Users/john/sw/lib -lglfw3 -framework Cocoa -framework OpenGL -framework IOKit -framework CoreVideo

example_programs := check_build  \
	opengl01 pendulum


# TARGETS
all: $(example_programs)

# This means that each example_program depends on a file with
# the same name but with ".c" appended
$(example_programs): % : %.c
	$(CC) $(CFLAGS) $^ -o $@ $(LDFLAGS)

clean:
	rm -f $(example_programs) *.dSYM
