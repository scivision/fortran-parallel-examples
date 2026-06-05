set_property(DIRECTORY PROPERTY LABELS openmp)

set(CMAKE_REQUIRED_LIBRARIES OpenMP::OpenMP_Fortran)

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
set_tests_properties(TimeMeasure PROPERTIES RUN_SERIAL true)

add_executable(jacobi jacobi_openmp.f90)
target_link_libraries(jacobi PRIVATE OpenMP::OpenMP_Fortran)
add_test(NAME Jacobi COMMAND jacobi)
set_tests_properties(Jacobi PROPERTIES RUN_SERIAL true)
