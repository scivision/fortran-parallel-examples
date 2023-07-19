# Fortran Parallel Examples

[![cmake](https://github.com/scivision/fortran-parallel-examples/actions/workflows/cmake.yml/badge.svg)](https://github.com/scivision/fortran-parallel-examples/actions/workflows/cmake.yml)
[![oneapi-linux](https://github.com/scivision/fortran-parallel-examples/actions/workflows/oneapi-linux.yml/badge.svg)](https://github.com/scivision/fortran-parallel-examples/actions/workflows/oneapi-linux.yml)

Examples of parallel runtimes from native Fortran syntax.
[Fortran coarrays or direct MPI operations](https://github.com/scivision/fortran-coarray-mpi-examples)
are in a separate repo.

Examples include:

* do concurrent: including Fortran 202x "reduce" syntax supported by NVIDIA HPC SDK and Intel oneAPI
* OpenACC: directive for Fortran
* openmp: OpenMP threading examples

## OpenMP

macOS users may need to install OpenMP libraries:

```sh
brew install libomp
```

For such a macOS install, tell CMake where OpenMP libraries are by setting environment variable:

```sh
export OpenMP_ROOT=/opt/homebrew/opt/libomp
```
