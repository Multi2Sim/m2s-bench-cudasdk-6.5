# m2s-bench-cudasdk-6.5


## Build Instructions

All of the benchmark programs can be built by running the make command in each directory. This will create an executable including both host code and device code. Also, the user copy of Multi2Sim should have been configured and built according to the instructions provided at https://www.multi2sim.org/development/multi2sim.php. The building of the benchmarks was tested on a system running Ubuntu 14.04, Linux kernel 3.13.0-46-generic, and GCC 4.8.2 

## How to run Benchmarks

m2s executable

For example, if we want to run VectorAdd benchmark. After downloading the whole benchmark, run

cd VectorAdd
make

After make, you will see there is and executable named VectorAdd and the kernel code named VectorAdd.cubin generated. 

For emulation, run
m2s VectorAdd 

Also if you want to see the kernel assembly code, run

m2s VectorAdd.cubin

## Disassembly and Emulation Support

| Benchmark          | Disassembly     | Emulation     |
|--------------------|-----------------|---------------|
| AsyncAPI           |                 |   supported   |
| CppIntegration     |                 |   supported   |
| CppOverload        |                 |   supported   |
| DeviceQuery        |                 |   supported   |
| InlinePTX          |                 |   supported   |
| SimpleCallback     |                 |   supported   |
| SimpleTemplates    |                 |   supported   |

