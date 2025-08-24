program timeprec
!! demonstrates  timing methods
use, intrinsic:: iso_fortran_env, only: real64, int64

implicit none

integer(int64) :: tic,toc,rate

call system_clock(tic,count_rate=rate)
call timempi()
call system_clock(toc)

print '(A,f9.3,A)','intrinsic time: ', real(toc-tic, real64) * 1000 / rate,' milliseconds.'


contains


subroutine timempi()

use omp_lib

integer :: Ncore, Nthread
real(real64) :: tic,toc

print '(A,ES10.3,A)','OpenMP tick time: ',omp_get_wtick(),' second.'

!$omp parallel private(tic,toc)

tic = omp_get_wtime()
! left these statements here to give a little entropy to per-thread timing.
Ncore = omp_get_num_procs()
Nthread = omp_get_num_threads()

!! OpenMP 5.1 introduced "masked" to replace "master"
!! https://www.openmp.org/wp-content/uploads/OpenMPRefCard-5.1-web.pdf

!$omp master
  print *,Nthread,'CPU threads used.',Ncore,' processor cores detected.'
!$omp end master

toc = omp_get_wtime()

print '(a,1x,i0,1x,a,1x,f9.3)','Thread:',omp_get_thread_num(),'elapsed (milliseconds):', (toc-tic) * 1000

!$omp end parallel
end subroutine timempi


end program
