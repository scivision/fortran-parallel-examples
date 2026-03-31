cmake_minimum_required(VERSION 3.19...4.4)

if(CMAKE_SOURCE_DIR STREQUAL CMAKE_BINARY_DIR)
  message(FATAL_ERROR "Please specify build directory like:
  cmake -B build")
endif()

project(FortranParallelExamples LANGUAGES Fortran)

enable_testing()

message(STATUS "CMake ${CMAKE_VERSION}")

include(cmake/compilers.cmake)

foreach(d IN ITEMS do_concurrent openacc openmp)
  add_subdirectory(${d})
endforeach()

file(GENERATE OUTPUT .gitignore CONTENT "*")
