!! based on https://github.com/jeng1220/openacc_fortran_examples/blob/master/acc_async/acc_async.f90

program main

use, intrinsic :: iso_fortran_env, only : int64, real64

implicit none

integer :: i, n, m
real, allocatable :: buf(:, :)
integer(int64) :: tic, toc, trate

m = 10
n = 10000
allocate(buf(n, m))

call system_clock(count_rate=trate)

!$acc kernels copy(buf)
buf = 0
!$acc end kernels

print '(a)', 'starting non-async'
call system_clock(tic)
do i = 1, m
    call without_async(buf(:, i), n)
end do
call system_clock(toc)
print '("Without OpenACC async time = ",f6.3," seconds.")', real(toc - tic, real64) / trate

call system_clock(tic)
do i = 1, m
    call with_async(buf(:, i), n, mod(i, 2) + 1)
end do
!$acc wait(1, 2)
call system_clock(toc)
print '("With OpenACC async time = ",f6.3," seconds.")', real(toc - tic, real64) / trate
deallocate(buf)

contains

subroutine with_async(x, n, id)
integer, intent(in) :: n, id
real, intent(inout) :: x(n)

integer :: i

!$acc kernels copy(x) async(id)
do i = 1, 5000
    x = x * 2 + 1
end do
!$acc end kernels
end subroutine

subroutine without_async(x, n)
integer, intent(in) :: n
real, intent(inout) :: x(n)

integer :: i

!$acc kernels copy(x)
do i = 1, 5000
    x = x * 2 + 1
end do
!$acc end kernels
end subroutine

end program
