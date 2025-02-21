! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
!
! mainprogram.f90
!
! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

 program mainprogram

! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
!
! Main program for two-point correlators in NRQCD quarkonium.
!
! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    use userparameters
    use lattice
    use gaugefields
    use heavyoperators
    use heavypropagators
    implicit none

    character(len=1000)                    :: cfgfile, corrfile_1s0, corrfile_3s1
    logical                              :: cutboundaries, backward, imp, &
                                            newgaugefield
    integer(kind=KI)                     :: it, nstoutsnk, nstoutsrc, &
                                            mode, iform, isrc, iaction, ierr, &
                                            itnbr, srcx, srcy, srcz
    integer(kind=KI), dimension(3)       :: src
    integer(kind=KI), dimension(4,nxyzt) :: bwdnbr, fwdnbr
    real(kind=KR)                        :: plaq, uzerot, uzeros, astoutsrc, &
                                            astoutsnk, aspect, bareM, &
                                            unitaritycf, csetmin
    real(kind=KR),    dimension(2,14)    :: cset
    complex(kind=KC)                     :: corr1s0,corr3s1x,corr3s1y,corr3s1z, corr1p1x,corr1p1y,corr1p1z

    complex(kind=KC), allocatable, dimension(:,:,:,:)     :: Utad, Ufat
    complex(kind=KC), allocatable, dimension(:,:,:,:,:,:) :: Gt

! An integer that defines which NRQCD Lagrangian is used.
    iaction = 7 ! Default is 4

! Configuration file name.
    read *,cfgfile

! Correlator files.
    read *,corrfile_1s0
    read *,corrfile_3s1

! Stout smearing.
    nstoutsrc = 0
    nstoutsnk = 0
    astoutsrc = 0.0_KR
    astoutsnk = 0.0_KR

! mode is a positive integer affecting the c6 and c11 terms in NRQCD.
    mode = 2

! tadpole factors.
    uzeros = 1.0_KR
    uzerot = 1.0_KR

! csetmin is the smallest magnitude of c0,c1,... that is not set to zero.
    csetmin = 1.0e-6_KR

! Coefficients of the NRQCD action that are outside of mode.
    cset(1,:) = 0.0_KR
    cset(1,1) = 1.0_KR

! Coefficients of the NRQCD action that are outside of mode.
! YT20250218 Just cset(2,5) for Davies 1993; This corresponds to sigma.B.
    
    cset(2,:) = 0.0_KR

!    cset(2,2) = 1.0_KR
!    cset(2,3) = 1.0_KR
!    cset(2,4) = 1.0_KR
    cset(2,5) = 1.0_KR
!    cset(2,6) = 1.0_KR
!    cset(2,7) = 1.0_KR

! Source position.
    srcx = 1
    srcy = 1
    srcz = 1

! Bare heavy quark mass.
    bareM = 2.3_KR

! Allocate large arrays. 
    allocate(Utad(nc,nc,ndir,nxyzt),stat=ierr)
    if (ierr/=0) then
     write(*,*) "mainprogram: unable to allocate Utad"
     stop
    endif
    allocate(Gt(nc,np,nxyz,nc,np,1),stat=ierr)
    if (ierr/=0) then
     write(*,*) "mainprogram: unable to allocate Gt"
     stop
    endif
    allocate(Ufat(nc,nc,ndir-1,nxyz),stat=ierr)
    if (ierr/=0) then
     write(*,*) "mainprogram: unable to allocate Ufat"
     stop
    endif

! Define some constants for the NRQCD propagators.
    select case(iaction)
     case(1)
      iform = 1
      imp = .false.
     case(2)
      iform = 1
      imp = .true.
     case(3)
      iform = 2
      imp = .false.
     case(4)
      iform = 2
      imp = .true.
     case(5)
      iform = 3
      imp = .false.
     case(6)
      iform = 3
      imp = .true.

     case(7)
       iform = 4      ! YT20250212
       imp = .false.  ! YT20250212

     case default ! never get here
      write(*,*) "mainprogram: invalid case(iaction)", iaction
      stop
    end select
    aspect = 1.0_KR
    unitaritycf = 2.0_KR*real(ndir-1,KR)*(1.0_KR - 1.0_KR/uzeros**2)

! Determine the identities of neighbouring lattice sites.
    call nbhd(bwdnbr,fwdnbr)

! Read the configuration file and compute the average plaquette.
    call configreadshift(cfgfile,0,Utad)
    if (nt<largeNt) then
     cutboundaries = .true.
    else
     cutboundaries = .false.
    endif
!    call aveplaq(Utad,cutboundaries,bwdnbr,fwdnbr,plaq)
!    write(unit=*,fmt="(a,es18.10)") "plaq = ", plaq
    call aveplaq(Utad,.false.,bwdnbr,fwdnbr,plaq) ! YT 20240620
    write(unit=*,fmt="(a,es18.10)") "plaq = ", plaq ! YT 20240620


! Apply the tadpole factors.
    call tadfield(Utad,uzeros,uzerot)

! Create the desired set of source operators.
    it = 1
    isrc = srcx + nx*(srcy-1) + nx*ny*(srcz-1)
    call fatfield(Utad,uzeros,it,nstoutsrc,astoutsrc,bwdnbr,fwdnbr,Ufat)
    call Ssource(isrc,Gt)

! Open correlator files for ^1S_0, ^3S_1, ^1P_1, ^3P_0 states.

    open(unit=11, file=corrfile_1s0, form="formatted", status="replace")
    open(unit=12, file=corrfile_3s1, form ="formatted", status="replace")
!    open(unit=13, file=corrfile_1p1, form="formatted", status="replace")
!    open(unit=14, file=corrfile_3p0, form="formatted", status="replace")

! Compute the 2-point correlators at the source time step.
    call fatfield(Utad,uzeros,it,nstoutsnk,astoutsnk,bwdnbr,fwdnbr,Ufat)
    call Smeson(Gt,corr1s0,corr3s1x,corr3s1y,corr3s1z)
    write(unit=11,fmt="(i5,2es18.10)") it, corr1s0
    write(unit=12,fmt="(i5,2es18.10,2es18.10,2es18.10)") it, corr3s1x, corr3s1y, corr3s1z

! Compute the heavy quark propagators and meson 2-point correlators.
    newgaugefield = .true.
    backward = .false.
    do it = 2,nt-4
     itnbr = it - 1
     call heavyprop(Gt,Utad,1,backward,bareM,itnbr,mode,cset,csetmin, &
                    imp,aspect,unitaritycf,iform,bwdnbr,fwdnbr, &
                    newgaugefield,uzeros,uzerot)
     newgaugefield = .false.
     call fatfield(Utad,uzeros,it,nstoutsnk,astoutsnk,bwdnbr,fwdnbr,Ufat)
     call Smeson(Gt,corr1s0,corr3s1x,corr3s1y,corr3s1z)
     write(unit=11,fmt="(i5,2es18.10)") it, corr1s0
     write(unit=12,fmt="(i5,2es18.10,2es18.10,2es18.10)") it, corr3s1x, corr3s1y, corr3s1z
    enddo ! it
    write(*,*) "RUNNING COMPLETED"

! Deallocate the large arrays.
    deallocate(Utad,stat=ierr)
    deallocate(Gt,stat=ierr)
    deallocate(Ufat,stat=ierr)

! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

! Close correlator files
    close(unit=11)
    close(unit=12)
!    close(unit=13)
!    close(unit=14)

 end program mainprogram

! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
