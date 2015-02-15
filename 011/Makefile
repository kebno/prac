# General Makefile

CC= c++
CPPFLAGS =  -g -Wall

UNAME := $(shell uname)
ifeq ($(UNAME), Linux)
	HEADDIR = /usr/include
	LIBDIR = /usr/lib
	INCLUDES = -I$(HEADDIR)
	LDFLAGS = -L$(HEADDIR)
	LIBS = -lgsl -lm
endif
ifeq ($(UNAME), Darwin)
	HEADDIR = /usr/local/Cellar
	LIBDIR = /usr/local/Cellar
	INCLUDES = -I$(HEADDIR)/gsl/1.16/include
	LDFLAGS = -L$(HEADDIR)/gsl/1.16/lib
	LIBS = -lgsl
endif

PROG = main

all: $(PROG)

main: main.cpp
	$(CC) $(INCLUDES) main.cpp $(LDFLAGS) $(LIBS) -o main
