CC=gcc
CFLAGS=-Wall -g -O2
LDFLAGS+=-lm -lc -lliquid

example_programs :=                              \
	passthrough                              \
	fir-filter/moving-average-from-files     \
	simple-passthrough                       \

# TARGETS
all: $(example_programs)

# This means that each example_program depends on a file with 
# the same name but with ".c" appended
$(example_programs): % : %.c
	$(CC) $(CFLAGS) $^ -o $@ $(LDFLAGS)

clean:
	rm -f $(example_programs)
