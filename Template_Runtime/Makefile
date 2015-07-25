#Makefile 

CCFLAGS = -m32
NVCCFLAGS = -arch sm_35 -c -m32 -Xcicc -O0 -Xptxas -O0
CC = g++ 
NVCC = nvcc
LDFLAGS = -lm2s-cuda
LDINC = -L ~/multi2sim/lib/.libs
INC = -I../include -I../inc


objects = template_runtime_disop.o

template_runtime_m2s :  $(objects)
	$(CC)  $^ -o $@ $(CCFLAGS) $(LDINC) $(LDFLAGS) -I../include 

template_runtime_disop.o : template_runtime.cu
	$(NVCC) -c $<  $(NVCCFLAGS) $(INC) -o $@
clean :
	rm template_runtime_m2s $(objects)
