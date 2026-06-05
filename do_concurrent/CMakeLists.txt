set_property(DIRECTORY PROPERTY LABELS "do_concurrent")

set(names do_concurrent_reduction)

foreach(t IN LISTS names)
  add_executable(${t} ${t}.f90)
  target_link_libraries(${t} PRIVATE $<$<Fortran_COMPILER_ID:IntelLLVM>:OpenMP::OpenMP_Fortran>)

  add_test(NAME ${t} COMMAND ${t})
endforeach()
