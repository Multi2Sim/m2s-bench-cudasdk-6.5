#include<iostream>
#include<stdio.h>
#include<stdlib.h>
#include<time.h>
#define NThreads 64
#define NBlocks 16

#define Num NThreads*NBlocks

__global__ void bitonic_sort_step(int *arr, int i, int j)
{
	unsigned int tid = blockIdx.x * blockDim.x + threadIdx.x;
	unsigned int tid_comp = tid ^ j;
	if (tid_comp > tid)
	{
		if ((tid & i) == 0)
		{
			//ascending
			if (arr[tid] > arr[tid_comp])
			{
				int temp = arr[tid];
				arr[tid] = arr[tid_comp];
				arr[tid_comp] = temp;
			}
		}
		else
		{
			//descending
			if (arr[tid] < arr[tid_comp])
			{
				int temp = arr[tid];
				arr[tid] = arr[tid_comp];
				arr[tid_comp] = temp;
			}

		}
	}
}

int main(int argc, char* argv[])
{
    int* arr= (int*) malloc(Num*sizeof(int));
    int* arr_temp = (int*) malloc(Num*sizeof(int));

    // Initialization
    time_t t;
    srand((unsigned)time(&t));
    for(int i=0;i<Num;i++){
        arr[i] = rand() % 10000;
    	//arr[i] = i;
     }

    //init device variable
    int* dev_ptr;
    cudaMalloc((void**)&dev_ptr,Num*sizeof(int));
    cudaMemcpy(dev_ptr,arr,Num*sizeof(int),cudaMemcpyHostToDevice);

 /*
    for(int i=0;i<Num;i++)
    {
        printf("%d\t",arr[i]);
    }
 */
    printf("\n End initialization \n");


    dim3 blocks(NBlocks,1);
    dim3 threads(NThreads,1);

    // bitonic sort
    for(unsigned int i=2; i<=Num; i<<=1)
    {
    	// bitonic merge
        for(unsigned int j=i>>1; j>0; j>>=1)
        {
        	bitonic_sort_step<<<blocks,threads>>>(dev_ptr,i,j);
   /*     	cudaMemcpy(arr_temp,dev_ptr,Num*sizeof(int),cudaMemcpyDeviceToHost);
            for(int i=0;i<Num;i++){
                printf("%d\t",arr_temp[i]);
            }
            printf("\n");
    */
        }
    }

    cudaMemcpy(arr,dev_ptr,Num*sizeof(int),cudaMemcpyDeviceToHost);

    // Self validation
    bool flag = true;
    for(int i = 0;i < Num - 1;i++)
    {
    	if (arr[i] > arr[i+1])
    	{
    		flag = false;
    		break;
    	}
    }

    if (flag)
    	printf("\nVerification passes\n");
    else
    	printf("\nVerification fails\n");

    cudaFree(dev_ptr);
    return 0;
}
