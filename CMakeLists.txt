cmake_minimum_required(VERSION 3.19...3.27)

if(CMAKE_SOURCE_DIR STREQUAL CMAKE_BINARY_DIR)
  message(FATAL_ERROR "Please specify build directory like:
  cmake -B build")
endif()

project(FortranParallelExamples
LANGUAGES Fortran)

enable_testing()

include(cmake/compilers.cmake)

foreach(d IN ITEMS do_concurrent openacc openmp)
  add_subdirectory(${d})
endforeach()

file(GENERATE OUTPUT .gitignore CONTENT "*")
