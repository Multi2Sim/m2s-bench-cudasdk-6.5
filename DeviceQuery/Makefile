#Makefile 

CCFLAGS = -m32
CC = g++ 
LDFLAGS = -lm2s-cuda
LDINC = -L ~/multi2sim/lib/.libs
INC = -I../include -I../inc



deviceQuery_m2s : deviceQuery.cpp
	$(CC)  $^ -o $@ $(CCFLAGS) $(INC) $(LDINC) $(LDFLAGS)

clean :
	rm deviceQuery_m2s 
