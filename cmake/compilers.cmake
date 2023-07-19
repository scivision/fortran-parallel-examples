include(CheckSourceCompiles)

if(CMAKE_Fortran_COMPILER_ID MATCHES "^Intel")
  add_compile_options(
  "$<$<COMPILE_LANGUAGE:Fortran>:-traceback;-heap-arrays>"
  "$<$<AND:$<COMPILE_LANGUAGE:Fortran>,$<CONFIG:Debug>>:-warn;-debug;-check>"
  )

  # parallel options--needed for "do concurrent" also.

  if(CMAKE_Fortran_COMPILER_ID MATCHES "^Intel")
    if(CMAKE_Fortran_COMPILER_ID STREQUAL "IntelLLVM")
      add_compile_options($<IF:$<BOOL:${WIN32}>,/Qiopenmp,-fiopenmp>)
    endif()
    add_link_options(-qopenmp)
  endif()
elseif(CMAKE_Fortran_COMPILER_ID STREQUAL "GNU")

  add_compile_options(
  $<$<COMPILE_LANGUAGE:Fortran>:-fimplicit-none>
  "$<$<AND:$<COMPILE_LANGUAGE:Fortran>,$<CONFIG:Release>>:-fno-backtrace;-Wno-maybe-uninitialized>"
  "$<$<AND:$<COMPILE_LANGUAGE:Fortran>,$<CONFIG:Debug>>:-Wall;-fcheck=all;-Werror=array-bounds>"
  )
elseif(CMAKE_Fortran_COMPILER_ID STREQUAL "NVHPC")
  # necessary for parallel run benefits
  # just "-stdpar" assumes GPU, which will fail if GPU not present
  add_compile_options(-stdpar=multicore)
endif()

include(${CMAKE_CURRENT_LIST_DIR}/f202x_do_concurrent.cmake)
