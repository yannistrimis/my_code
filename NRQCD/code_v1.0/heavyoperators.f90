! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
!
! heavyoperators.f90
!
! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

 module heavyoperators

! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
!
! This module create a two-point correlation function for quarkonium.
! The gauge fields and heavy propagators must already exist.
!
! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    use userparameters
    implicit none
    private

! Define access to subroutines.
    public :: Ssource, Smeson

 contains

! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

 subroutine Ssource(isrc,G)
! Create a source, intended for use as the starting source for
! subsequent computation of a heavy quark propagator.
! INPUT:
!   isrc = ix + nx*(iy-1) + nx*ny*(iz-1) is the spatial site of a point source.
! OUTPUT:
!   G(ic,ip,ixyz,jc,jp,iop) is the collection of sources.
!                      ic   is the color index of the sink.
!                      ip   is the Pauli index of the sink.
!                      ixyz is spatial location of the sink.
!                      jc   is the color index of the source.
!                      jp   is the Pauli index of the source.
!                      iop  is to identify the various source operators.
!   (ic=jc, ip=jp and ixyz=jxyz because no time propagation has occurred yet.)

    integer(kind=KI), intent(in)                          :: isrc
    complex(kind=KC), intent(out), dimension(:,:,:,:,:,:) :: G

    integer(kind=KI) :: ip, ic

    G = (0.0_KR,0.0_KR)
    do ip = 1,np
     do ic = 1,nc
      G(ic,ip,isrc,ic,ip,1) = (1.0_KR,0.0_KR)
     enddo ! ic
    enddo ! ip

 end subroutine Ssource

! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

 subroutine Smeson(G1,corr1s0,corr3s1x,corr3s1y,corr3s1z)
! Construct a meson correlator at one time step from given propagators.
! INPUT:
!   G1() is the propagator for the quark.
! OUTPUT:
!   corr1s0 is the correlation function for ^1S_0 (0-+).
!   corr3s1x/y/z are the correlation functions for ^3S_1 (1--).

    complex(kind=KC), intent(in),  dimension(:,:,:,:,:,:) :: G1
    complex(kind=KC), intent(out)                         :: corr1s0
    complex(kind=KC), intent(out)                         :: corr3s1x
    complex(kind=KC), intent(out)                         :: corr3s1y
    complex(kind=KC), intent(out)                         :: corr3s1z


    complex(kind=KC),  dimension(np,np) :: sig_x
    complex(kind=KC),  dimension(np,np) :: sig_y
    complex(kind=KC),  dimension(np,np) :: sig_z

    integer(kind=KI) :: ic, ip, ix, iy, iz, ixyz, jc, jp
    integer(kind=KI) :: kp, lp

    sig_x(1,1) = (0.0_KR,0.0_KR)
    sig_x(1,2) = (1.0_KR,0.0_KR)
    sig_x(2,1) = (1.0_KR,0.0_KR)
    sig_x(2,2) = (0.0_KR,0.0_KR)

    sig_y(1,1) = (0.0_KR,0.0_KR)
    sig_y(1,2) = (0.0_KR,-1.0_KR)
    sig_y(2,1) = (0.0_KR,1.0_KR)
    sig_y(2,2) = (0.0_KR,0.0_KR)

    sig_z(1,1) = (1.0_KR,0.0_KR)
    sig_z(1,2) = (0.0_KR,0.0_KR)
    sig_z(2,1) = (0.0_KR,0.0_KR)
    sig_z(2,2) = (-1.0_KR,0.0_KR)

    corr1s0 = (0.0_KR,0.0_KR)
    corr3s1x = (0.0_KR,0.0_KR)
    corr3s1y = (0.0_KR,0.0_KR)
    corr3s1z = (0.0_KR,0.0_KR)

    ixyz = 0
    do iz = 1,nz
     do iy = 1,ny
      do ix = 1,nx
       ixyz = ixyz + 1
       do jc = 1,nc
        do ic = 1,nc
         do jp = 1,np
          do ip = 1,np
           corr1s0 = corr1s0 + conjg(G1(ic,ip,ixyz,jc,jp,1))*G1(ic,ip,ixyz,jc,jp,1)
           do kp = 1,np          
            do lp = 1,np
             corr3s1x = corr3s1x + conjg(G1(ic,ip,ixyz,jc,kp,1))*G1(ic,lp,ixyz,jc,jp,1)*sig_x(ip,lp)*sig_x(kp,jp)
             corr3s1y = corr3s1y + conjg(G1(ic,ip,ixyz,jc,kp,1))*G1(ic,lp,ixyz,jc,jp,1)*sig_y(ip,lp)*sig_y(kp,jp)
             corr3s1z = corr3s1z + conjg(G1(ic,ip,ixyz,jc,kp,1))*G1(ic,lp,ixyz,jc,jp,1)*sig_z(ip,lp)*sig_z(kp,jp)
            enddo ! lp
           enddo ! kp
          enddo ! ip
         enddo ! jp
        enddo ! ic
       enddo ! jc
      enddo ! ix
     enddo ! iy
    enddo ! iz

 end subroutine Smeson

! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

 end module heavyoperators

! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
