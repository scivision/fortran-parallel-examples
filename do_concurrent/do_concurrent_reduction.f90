program do_concurrent_reduction
!! code from https://wg5-fortran.org/N2151-N2200/N2194.pdf

!! In this example, the output values of `a` and `b` will be:
!! `xsqs`: The sum of the squares of the random values in `x`.
!! `mx`: The maximum value in the array `x`.
use, intrinsic :: iso_fortran_env, only: stderr=>error_unit

implicit none (type, external)

integer, parameter :: n = 1000000

real :: xsqs, mx
real, allocatable :: x(:)
integer :: i

allocate(x(n))

! Initialize x with random values between 0 and 1
call random_init(.false., .false.)
call random_number(x)

do concurrent (i = 1: n) reduce(+:xsqs) reduce(max:mx)
  xsqs = xsqs + x(i)**2
  mx = max(mx, x(i))
end do

deallocate(x)

print *, xsqs, mx

if (mx < 0 .or. mx > 1) then
  write(stderr, '(a)') 'Error: mx is out of range [0, 1]'
end if

end program
