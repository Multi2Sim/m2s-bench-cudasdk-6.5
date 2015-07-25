#Makefile 

CCFLAGS = -m32
NVCCFLAGS = -arch sm_35 -c -m32 -Xcicc -O0 -Xptxas -O0
CC = g++ 
NVCC = nvcc
LDFLAGS = -lm2s-cuda
LDINC = -L ~/multi2sim/lib/.libs
INC = -I../include -I../inc


objects = simpleMultiGPU_disop.o

simpleMultiGPU_m2s : $(objects)
	$(CC)  $^ -o $@ $(CCFLAGS) $(LDINC) $(LDFLAGS)

simpleMultiGPU_disop.o : simpleMultiGPU.cu
	$(NVCC) -c $<  $(NVCCFLAGS) $(INC) -o $@
clean :
	rm simpleMultiGPU_m2s $(objects)
