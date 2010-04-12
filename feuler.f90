

program feuler

  implicit none


  integer :: N, Nt, fout
  real*8  :: dx,dt,courant

  integer :: allocst
  integer :: i,j


  real*8, allocatable, dimension(:) :: x, phi, phi_p, phi_s 

  real*8 :: x0, sig, A

! Params
  N=4000
  dx= 0.1
  courant= 0.5
  dt = courant*dx
  Nt = 5000
  fout = 50

  x0 = 180.
  sig= 3.
  A = 1.0

! allocate and init data
  allocate( x(0:N-1),phi(0:N-1),phi_p(0:N-1),phi_s(0:N-1))
  open(unit=66,file='phi.rl',status='replace')


  do i = 0, N-1
     x(i)= dx*i
  end do
  phi = A*exp( - ( (x - x0) /sig)**2)
  phi_p = 0.0
  phi_s = 0.0



! write initial data  
  do i = 0, N-1
     write(66,*) x(i), phi(i)
  end do
  write(66,*) ''

! Loop
  do i = 1, Nt
     phi_p= phi
     ! Inner
     do j = 1, N-2
        phi_s(j) = (phi_p(j+1)-phi_p(j-1))/(2.0)
        phi(j) = phi_p(j) + courant*phi_s(j)
     end do
     ! Nothing on boundaries

     ! Output
     if(Mod(i,fout).eq.0) then
        do j = 0, N-1
           write(66,*) x(j), phi(j)
        end do
        write(66,*) ''     
        print*, i, i*dt
     end if

  end do


  close(66)

  deallocate( x,phi,phi_p,phi_s)

end program feuler
