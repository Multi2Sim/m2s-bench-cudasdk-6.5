#include "cuda_runtime.h"
#include"stdio.h"
//#include "matrixmul.cuh"

#define BLOCK_SIZE 	16
#define A_HEIGHT    	128
#define A_WIDTH		128
#define B_HEIGHT	128
#define B_WIDTH		128
#define C_HEIGHT	A_HEIGHT
#define C_WIDTH		B_WIDTH

__global__ void matrix_mulKernel(int *c, int *a, int *b,
		int a_height,int a_width, int b_width, int c_width)
{
	int col = blockIdx.x * blockDim.x + threadIdx.x;
	int row = blockIdx.y * blockDim.y + threadIdx.y;
	if(row >= a_height || col >= b_width) return;
	int i, sum=0;
	for(i =0; i<a_width; ++i)
	{
		sum += a[row * a_width + i] * b[i * b_width + col];
	}
	c[row * c_width + col] =sum;
}

void matrix_multiplication(const int *a, const int *b, int *c, int a_hiehgt, int b_width, int b_height);

void print_matrix( int *matrix, int height, int width);

int main()
{
	int *a = (int*) calloc(A_HEIGHT * A_WIDTH, sizeof(unsigned int) );
	int *b = (int*) calloc(B_HEIGHT * B_WIDTH, sizeof(unsigned int) );
	int *c = (int*) calloc(C_HEIGHT * C_WIDTH, sizeof(unsigned int) );
	int *d = (int*) calloc(C_HEIGHT * C_WIDTH, sizeof(unsigned int) );
	int i;
	for (i =0; i < A_HEIGHT * A_WIDTH; i++)
	{
		a[i] = i;
		b[i] = i;
	}

    int *dev_a = 0;
    int *dev_b = 0;
    int *dev_c = 0;

    // Allocate GPU buffers for three vectors (two input, one output)    .
    cudaMalloc((void**)&dev_c, C_HEIGHT * C_WIDTH * sizeof(unsigned int));


    cudaMalloc((void**)&dev_a, A_HEIGHT * A_WIDTH * sizeof(unsigned int));


    cudaMalloc((void**)&dev_b, B_HEIGHT * B_WIDTH * sizeof(unsigned int));

    // Copy input vectors from host memory to GPU buffers.
    cudaMemcpy(dev_a, a, A_HEIGHT * A_WIDTH * sizeof(unsigned int), cudaMemcpyHostToDevice);

    cudaMemcpy(dev_b, b, B_HEIGHT * B_WIDTH * sizeof(unsigned int), cudaMemcpyHostToDevice);

    dim3 dimBlock (BLOCK_SIZE,BLOCK_SIZE); // block( blockIdx, blockIDy)
    dim3 grid ((B_WIDTH + dimBlock.x - 1) / dimBlock.x,
    		(A_HEIGHT + dimBlock.y - 1) / dimBlock.y);		// grid(gloalsizeX + blockidx -1)/blockidx,gloalsizeY + blockidy -1)/blockidy);

    matrix_mulKernel<<<grid, dimBlock>>>(dev_c, dev_a, dev_b, A_HEIGHT, A_WIDTH, B_WIDTH, C_WIDTH);

    // Copy output vector from GPU buffer to host memory.
    cudaMemcpy(c, dev_c, C_HEIGHT * C_WIDTH * sizeof(int), cudaMemcpyDeviceToHost);


    matrix_multiplication(a, b ,d, A_HEIGHT, B_WIDTH, B_HEIGHT);

    bool flag = true;
    for(int i = 0; i < A_HEIGHT * B_WIDTH; i++ )
{

	if (c[i] != d[i])
	{
		printf("Verification fail\n");
		flag = false;
		break;
	}

}
    if (flag)
    	printf("Verification pass\n");
	//printf("Matrix A:\n");
	//print_matrix(a, size);
	//printf("Matrix B:\n");
	//print_matrix(b, size);
	printf("Matrix C:\n");
	print_matrix(c, 10, 10);
	printf("Matrix D:\n");
    	print_matrix(d,10, 10);
}


void matrix_multiplication(const int *a, const int *b, int *c, int a_height, int b_width, int b_height)
{
	for(int i = 0; i < a_height; i++)
	{
		for(int j = 0; j < b_width; j++)
		{
			int sum = 0;
			for(int k = 0; k < b_height ; k++)
			{
				sum+= a[i * b_height + k] * b[k * b_width + j];

			}
			c[i * b_width + j] = sum;
		}
	}
}

void print_matrix( int *matrix, int height, int width)
{
	int i , j;
	for(i = 0; i < width; i++)
{
	for(j = 0; j < height; j++)
		printf("%5d", matrix[i * width + j]);
	printf("\n");
}
}
