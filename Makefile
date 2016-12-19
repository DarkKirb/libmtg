SRCS = $(shell find src -type f -name '*.cpp' -o -name '*.c')
OBJS = $(addsuffix .o,$(basename $(SRCS)))
CXX = g++
CC = gcc
AR = ar
CFLAGS = -O2 -w -Werror -Wno-unused -fPIC -g -I. -Isrc/
ifeq ($(OS),Windows_NT)
    CFLAGS += -D WIN32
    ifeq ($(PROCESSOR_ARCHITEW6432),AMD64)
        CFLAGS += -D AMD64
    else
        ifeq ($(PROCESSOR_ARCHITECTURE),AMD64)
            CFLAGS += -D AMD64
        endif
        ifeq ($(PROCESSOR_ARCHITECTURE),x86)
            CFLAGS += -D IA32
        endif
    endif
else
		CFLAGS += -nostdlib
    #add support for the exceptions/ directory
		SRCS += $(shell find exceptions -type f -name '*.cpp' -o -name '*.c')
		OBJS = $(addsuffix .o,$(basename $(SRCS)))
    UNAME_S := $(shell uname -s)
    ifeq ($(UNAME_S),Linux)
        CFLAGS += -D LINUX
    endif
    ifeq ($(UNAME_S),Darwin)
        CFLAGS += -D OSX
    endif
		ifeq ($(UNAME_S),FreeBSD)
		    CFLAGS += -D FREEBSD
		endif
    UNAME_P := $(shell uname -p)
    ifeq ($(UNAME_P),x86_64)
        CFLAGS += -D AMD64
    endif
    ifneq ($(filter %86,$(UNAME_P)),)
        CFLAGS += -D IA32
    endif
    ifneq ($(filter arm%,$(UNAME_P)),)
        CFLAGS += -D ARM
    endif
endif
CXXFLAGS = $(CFLAGS) -std=gnu++14 -fexceptions
CFLAGS += -std=c11
all: libmtg.a
libmtg.a: $(OBJS)
	$(AR) rcs $@ $^

%.o: %.c
	$(CC) $(CFLAGS) -c -o $@ $^

%.o: %.cpp
	$(CXX) $(CXXFLAGS) -c -o $@ $^
clean:
	rm -rf $(OBJS)
distclean:
	rm -rf libmtg.a $(OBJS)
