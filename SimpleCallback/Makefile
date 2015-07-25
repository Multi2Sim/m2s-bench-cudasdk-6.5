#Makefile 

CCFLAGS = -m32
NVCCFLAGS = -arch sm_35 -c -m32 -Xcicc -O0 -Xptxas -O0
CC = g++ 
NVCC = nvcc
LDFLAGS = -lm2s-cuda -lpthread
LDINC = -L ~/multi2sim/lib/.libs
INC = -I../include -I../inc


objects = simpleCallback_disop.o

simpleCallback_m2s : multithreading.h multithreading.cpp $(objects)
	$(CC)  $^ -o $@ $(CCFLAGS) $(LDINC) $(LDFLAGS) -I../include 

simpleCallback_disop.o : simpleCallback.cu
	$(NVCC) -c $<  $(NVCCFLAGS) $(INC) -o $@
clean :
	rm simpleCallback_m2s $(objects)
