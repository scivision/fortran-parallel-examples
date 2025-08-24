set_property(DIRECTORY PROPERTY LABELS openmp)

if(CMAKE_Fortran_COMPILER_ID STREQUAL "LLVMFlang" AND CMAKE_VERSION VERSION_LESS 4.2)
  list(APPEND CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR}/cmake)
endif()

find_package(OpenMP COMPONENTS Fortran REQUIRED)

set(CMAKE_REQUIRED_FLAGS ${OpenMP_Fortran_FLAGS})
set(CMAKE_REQUIRED_INCLUDES ${OpenMP_Fortran_INCLUDE_DIRS})
set(CMAKE_REQUIRED_LIBRARIES ${OpenMP_Fortran_LIBRARIES})

check_source_compiles(Fortran
"program test
use, intrinsic :: iso_fortran_env, only: int64
use omp_lib

implicit none

integer(int64) :: rate
rate = omp_get_wtick()
end program"
HAS_OpenMP
)

if(NOT HAS_OpenMP)
  message(FATAL_ERROR "OpenMP could not link; see ${CMAKE_BINARY_DIR}/CMakeFiles/CMakeConfigureLog.yaml")
endif()


add_executable(timeprec openmp_time_precision.f90)
target_link_libraries(timeprec PRIVATE OpenMP::OpenMP_Fortran)
add_test(NAME TimeMeasure COMMAND timeprec)

add_executable(jacobi jacobi_openmp.f90)
target_link_libraries(jacobi PRIVATE OpenMP::OpenMP_Fortran)
add_test(NAME Jacobi COMMAND jacobi)

set_tests_properties(TimeMeasure Jacobi PROPERTIES RUN_SERIAL true)
