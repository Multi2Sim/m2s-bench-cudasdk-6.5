#Makefile 

CCFLAGS = -m32
NVCCFLAGS = -arch sm_35 -c -m32 -Xcicc -O0 -Xptxas -O0
CC = g++ 
NVCC = nvcc
LDFLAGS = -lm2s-cuda
LDINC = -L ~/multi2sim/lib/.libs
INC = -I../include -I../inc


objects = simpleStreams_disop.o

simpleStreams_m2s : $(objects)
	$(CC)  $^ -o $@ $(CCFLAGS) $(LDINC) $(LDFLAGS)

simpleStreams_disop.o : simpleStreams.cu
	$(NVCC) -c $<  $(NVCCFLAGS) $(INC) -o $@
clean :
	rm simpleStreams_m2s $(objects)
