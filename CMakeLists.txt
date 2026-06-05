cmake_minimum_required(VERSION 3.19...4.4)

if(CMAKE_SOURCE_DIR STREQUAL CMAKE_BINARY_DIR)
  message(FATAL_ERROR "Please specify build directory like:
  cmake -B build")
endif()

project(FortranParallelExamples LANGUAGES Fortran)

enable_testing()

message(STATUS "CMake ${CMAKE_VERSION}")

include(cmake/compilers.cmake)

find_package(OpenMP COMPONENTS Fortran)
# do_concurrent also require OpenMP on some compilers.

if(f202x_do_concurrent)
  add_subdirectory(do_concurrent)
endif()

if(OpenMP_Fortran_FOUND)
  add_subdirectory(openmp)
endif()

find_package(OpenACC)
if(OpenACC_Fortran_FOUND)
  add_subdirectory(openacc)
endif()

file(GENERATE OUTPUT .gitignore CONTENT "*")
