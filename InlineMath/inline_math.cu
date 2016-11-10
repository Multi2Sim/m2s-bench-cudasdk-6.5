#include <cuda.h>
#include <cuda_runtime.h>
#include <stdio.h>
#include <stdlib.h>
#include <iostream>

#include "repeat.h"
using namespace std;



__global__ void int_add (int *c, int *a, int *b)
{

  int i = *a;
  int j = *b;
  int k0, k1, k2, k3, k4, k5, k6;
  //k6, k7, k8, k9, k10, k11, k12, k13, k14, k15, k16,
  //k17, k18, k19, k20, k21, k22, k23, k24, k25, k26, k27, k28, k29, k30;
/*
  asm volatile (
 		"add.s32 %0, %1, %2;\n\t"
 	  : "=r"(k0) : "r"(i) , "r"(j)
 	  );

   asm volatile (
 		"add.s32 %0, %1, %2;\n\t"
 	  : "=r"(k1) : "r"(i) , "r"(j)
 	  );

   asm volatile (
 		"add.s32 %0, %1, %2;\n\t"
 	  : "=r"(k2) : "r"(i) , "r"(j)
 	  );

   asm volatile (
 		"add.s32 %0, %1, %2;\n\t"
 	  : "=r"(k3) : "r"(i) , "r"(j)
 	  );

   asm volatile (
 		"add.s32 %0, %1, %2;\n\t"
 	  : "=r"(k4) : "r"(i) , "r"(j)
 	  );


   asm volatile (
  		"sub.s32 %0, %1, %2;\n\t"
  	  : "=r"(k5) : "r"(i) , "r"(j)
  	  );
*/
  repeat25(
  asm volatile (
		"add.s32 %0, %0, %1;\n\t"
	  : "=r"(k0) : "r"(i) , "r"(j)
	  );

  asm volatile (
		"add.s32 %0, %0, %1;\n\t"
	  : "=r"(k1) : "r"(i) , "r"(j)
	  );

  asm volatile (
		"add.s32 %0, %0, %1;\n\t"
	  : "=r"(k2) : "r"(i) , "r"(j)
	  );

  asm volatile (
		"add.s32 %0, %0, %1;\n\t"
	  : "=r"(k3) : "r"(i) , "r"(j)
	  );

  asm volatile (
		"add.s32 %0, %0, %1;\n\t"
	  : "=r"(k4) : "r"(i) , "r"(j)
	  );


  asm volatile (
 		"sub.s32 %0, %1, %0;\n\t"
 	  : "=r"(k5) : "r"(i) , "r"(j)
 	  );
  )
 // printf("k = %d\n", k);
//  *c= k0;
 // *c = k1;
 // *c = k2;
 // *c = k3;
  //*c = k4;

  k6 = k5;
  k5 = k4;
  k4 = k3;
  k3 = k2;
  k2= k1;
  k1= k0;
  *c = k1;
}

int main()
{
	int length = sizeof(int);
	int *a = (int*)malloc(length);
	int *b = (int*)malloc(length);
	int *c = (int*)malloc(length);

	*a = 1;
	*b = 1;
	int *ad, *bd, *cd;
	// initialize device memory
	cudaMalloc( (void**)&ad, length);
	cudaMalloc( (void**)&bd, length);
	cudaMalloc( (void**)&cd, length);

	// copy data to device
	cudaMemcpy( ad, a, sizeof(int), cudaMemcpyHostToDevice );
	cudaMemcpy( bd, b, sizeof(int), cudaMemcpyHostToDevice );

	// setup block and grid size	
	int_add<<<2000, 256>>>(cd, ad, bd);
	cudaMemcpy( c, cd, sizeof(int), cudaMemcpyDeviceToHost );

	cout << "Kernel Finished" << endl;
	//Verify
/*
	bool flag;
	if (*c == 21)
		flag = true;
	else
	{
		flag = false;
		printf("result is %d\n", *c);
	}
	if(flag)
		cout << "Verification passes." << endl;
	else
		cout << "Verification fails." << endl;

*/
	// free device memory
	cudaFree( ad );
	cudaFree( bd );
	cudaFree (cd);
	return EXIT_SUCCESS;
}

