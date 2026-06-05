include(CheckSourceCompiles)

check_source_compiles(Fortran
"program test
implicit none
integer :: i
real :: s = 0.0, m = 0.0
real :: x(10) = 1.0

do concurrent (i = 1:10) reduce(+:s) reduce(max:m)
s = s + x(i)
m = max(m, x(i))
end do
end program"
f202x_do_concurrent
)

add_compile_options(
"$<$<COMPILE_LANG_AND_ID:Fortran,IntelLLVM>:-traceback>"
"$<$<AND:$<COMPILE_LANG_AND_ID:Fortran,IntelLLVM>,$<CONFIG:Debug>>:-warn;-debug;-check>"
)

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
