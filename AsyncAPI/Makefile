#Makefile 

CCFLAGS = -m32
NVCCFLAGS = -arch sm_35 -c -m32 -Xcicc -O0 -Xptxas -O0
NVCCCUBIN = -cubin -arch sm_35 -Xcicc -O0 -Xptxas -O0
CC = g++ 
NVCC = nvcc
LDFLAGS = -lm2s-cuda
LDINC = -L ~/multi2sim/lib/.libs
INC = -I../include -I../inc

all : AsyncAPI AsyncAPI.cubin

objects = async_disop.o

AsyncAPI : $(objects)
	$(CC)  $^ -o $@ $(CCFLAGS) $(LDINC) $(LDFLAGS)
async_disop.o : asyncAPI.cu
	$(NVCC) -c $<  $(NVCCFLAGS) $(INC) -o $@

AsyncAPI.cubin : asyncAPI.cu
	$(NVCC) $(NVCCCUBIN) $< -o $@ $(INC)
clean :
	rm AsyncAPI AsyncAPI.cubin $(objects)
