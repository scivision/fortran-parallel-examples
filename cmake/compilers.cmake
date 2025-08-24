include(CheckSourceCompiles)

# parallel options--needed for "do concurrent" also.
 add_compile_options(
"$<$<COMPILE_LANG_AND_ID:Fortran,IntelLLVM>:$<IF:$<BOOL:${WIN32}>,/Qopenmp,-fiopenmp>>"
"$<$<COMPILE_LANG_AND_ID:Fortran,IntelLLVM>:-traceback;-heap-arrays>"
"$<$<AND:$<COMPILE_LANG_AND_ID:Fortran,IntelLLVM>,$<CONFIG:Debug>>:-warn;-debug;-check>"
 )

add_link_options("$<$<COMPILE_LANG_AND_ID:Fortran,IntelLLVM>:-qopenmp>")

add_compile_options(
$<$<COMPILE_LANG_AND_ID:Fortran,GNU>:-fimplicit-none>
"$<$<AND:$<COMPILE_LANG_AND_ID:Fortran,GNU>,$<CONFIG:Release>>:-fno-backtrace;-Wno-maybe-uninitialized>"
"$<$<AND:$<COMPILE_LANG_AND_ID:Fortran,GNU>,$<CONFIG:Debug>>:-Wall;-fcheck=all;-Werror=array-bounds>"
)

# necessary for parallel run benefits
# just "-stdpar" assumes GPU, which will fail if GPU not present
# like Intel compiler, needs both compile and link options
add_compile_options("$<$<COMPILE_LANG_AND_ID:Fortran,NVHPC>:-stdpar=multicore>")
add_link_options("$<$<COMPILE_LANG_AND_ID:Fortran,NVHPC>:-stdpar=multicore>")

include(${CMAKE_CURRENT_LIST_DIR}/f202x_do_concurrent.cmake)
