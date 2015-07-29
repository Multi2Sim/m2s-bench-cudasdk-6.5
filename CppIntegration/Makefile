#Makefile 

CCFLAGS = -m32
NVCCFLAGS = -arch sm_35 -c -m32 -Xcicc -O0 -Xptxas -O0
CC = g++ 
NVCC = nvcc
LDFLAGS = -lm2s-cuda
LDINC = -L ~/multi2sim/lib/.libs
INC = -I../include -I../inc


objects = cppIntegration_disop.o

CppIntegration : cppIntegration_gold.cpp main.cpp $(objects)
	$(CC)  $^ -o $@ $(CCFLAGS) $(LDINC) $(LDFLAGS) -I../include 

cppIntegration_disop.o : cppIntegration.cu
	$(NVCC) -c $<  $(NVCCFLAGS) $(INC) -o $@
clean :
	rm CppIntegration $(objects)
