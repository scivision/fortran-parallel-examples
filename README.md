# Fortran Parallel Examples

[![cmake](https://github.com/scivision/fortran-parallel-examples/actions/workflows/cmake.yml/badge.svg)](https://github.com/scivision/fortran-parallel-examples/actions/workflows/cmake.yml)
[![oneapi-linux](https://github.com/scivision/fortran-parallel-examples/actions/workflows/oneapi-linux.yml/badge.svg)](https://github.com/scivision/fortran-parallel-examples/actions/workflows/oneapi-linux.yml)

Examples of parallel runtimes from native Fortran syntax.
[direct MPI operations](https://github.com/scivision/fortran-mpi-examples)
or
[Fortran Coarrays](https://github.com/scivision/fortran-coarray-examples)
are in separate repos.

Examples include:

* do concurrent: including Fortran 202x "reduce" syntax supported by NVIDIA HPC SDK and Intel oneAPI
* OpenACC: directive for Fortran
* openmp: OpenMP threading examples

## OpenMP

macOS users may need to
[install OpenMP library](https://gist.github.com/scivision/16c2ca1dc250f54d34f1a1a35596f4a0).

## OpenACC

Not every compiler supports OpenACC.
For example, Intel oneAPI does not support OpenACC, but provides a
[migration tool](https://www.intel.com/content/www/us/en/developer/articles/technical/migration-of-openacc-api-to-openmp-api.html)
from OpenACC to OpenMP.

NVIDIA HPC SDK generally shows a clear (say 10s of percent) runtime improvement with OpenACC on these example.
Other compilers like GCC might show little advantage.
