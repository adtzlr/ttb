! -----------MODULE TENSOR---------------------------------------
       module Tensor
       ! ---------------------------------------
       ! Tensor Toolbox Module for Fortran
       ! Andreas Dutzler
       ! Graz University of Technology
       ! Institute of Structural Durability
       !    and Railway Technology
       ! ---------------------------------------
       ! tested on: Windows 10 (64bit)
       ! - Intel Fortran >2015
       ! - MinGW gfortran >6.3
       ! ---------------------------------------
       ! use this module in the following form:
       ! ---------------------------------------
       ! include 'ttb/ttb_library.f'
       ! program sample
       !  use Tensor
       !  ...
       ! end program sample
       ! ---------------------------------------
       
       type Tensor1
        ! tensor of rank 1
        real(kind=8), dimension(3) :: a = 0.d0
       end type Tensor1
       
       type Tensor2
        ! tensor of rank 2
        real(kind=8), dimension(3,3) :: ab = 0.d0
       end type Tensor2
       
       type Tensor2S
        ! symmetric tensor of rank 2 stored as vector
        real(kind=8), dimension(6) :: a6 = 0.d0
       end type Tensor2S
       
       type Tensor4
        ! tensor of rank 4
        real(kind=8), dimension(3,3,3,3) :: abcd = 0.d0
       end type Tensor4
       
       type Tensor4S
        ! symmetric tensor of rank 4 stored as 6x6 matrix
        real(kind=8), dimension(6, 6) :: a6b6 = 0.d0
       end type Tensor4S

!      ------BEGIN INTERFACE-------------------------------------
       interface operator (/)
       module procedure div_10
       module procedure div_20
       module procedure div_20s
       module procedure div_40
       module procedure div_40s
       module procedure div_10_r4
       module procedure div_20_r4
       module procedure div_20s_r4
       module procedure div_40_r4
       module procedure div_40s_r4
       end interface
       interface operator (.div.)
       module procedure div_10
       module procedure div_20
       module procedure div_20s
       module procedure div_40
       module procedure div_40s
       module procedure div_10_r4
       module procedure div_20_r4
       module procedure div_20s_r4
       module procedure div_40_r4
       module procedure div_40s_r4
       end interface
       
       interface operator (*)
       ! simple dot-product of rank 1 and rank 2 tensor combinations
       module procedure dot_01
       module procedure dot_10
       module procedure dot_02
       module procedure dot_02s
       module procedure dot_20
       module procedure dot_20s
       module procedure dot_04
       module procedure dot_04s
       module procedure dot_40
       module procedure dot_40s
       module procedure dot_11
       module procedure dot_12
       module procedure dot_21
       module procedure dot_2s1
       module procedure dot_12s
       module procedure dot_22
       module procedure dot_2s2s
       module procedure dot_01_r4
       module procedure dot_10_r4
       module procedure dot_02_r4
       module procedure dot_02s_r4
       module procedure dot_20_r4
       module procedure dot_20s_r4
       module procedure dot_04_r4
       module procedure dot_04s_r4
       module procedure dot_40_r4
       module procedure dot_40s_r4
       end interface
       interface operator (.dot.)
       ! simple dot-product of rank 1 and rank 2 tensor combinations
       module procedure dot_01
       module procedure dot_10
       module procedure dot_02
       module procedure dot_02s
       module procedure dot_20
       module procedure dot_20s
       module procedure dot_04
       module procedure dot_04s
       module procedure dot_40
       module procedure dot_40s
       module procedure dot_11
       module procedure dot_12
       module procedure dot_21
       module procedure dot_2s1
       module procedure dot_12s
       module procedure dot_22
       module procedure dot_2s2s
       module procedure dot_01_r4
       module procedure dot_10_r4
       module procedure dot_02_r4
       module procedure dot_02s_r4
       module procedure dot_20_r4
       module procedure dot_20s_r4
       module procedure dot_04_r4
       module procedure dot_04s_r4
       module procedure dot_40_r4
       module procedure dot_40s_r4
       end interface
       
       interface operator (**)
       ! double dot-product of rank 1 and rank 2 tensor combinations
       module procedure ddot_22
       module procedure ddot_2s2s
       module procedure ddot_24
       module procedure ddot_2s4s
       module procedure ddot_42
       module procedure ddot_4s2s
       module procedure ddot_44
       module procedure ddot_4s4s
       module procedure pow_2
       module procedure pow_2s
       end interface
       
       interface operator (.ddot.)
       ! double dot-product of rank 1 and rank 2 tensor combinations
       module procedure ddot_22
       module procedure ddot_2s2s
       module procedure ddot_24
       module procedure ddot_2s4s
       module procedure ddot_42
       module procedure ddot_4s2s
       module procedure ddot_44
       module procedure ddot_4s4s
       end interface
       
       interface operator (.pow.)
       module procedure pow_2
       module procedure pow_2s
       end interface
       
       interface operator (+)
       ! addition of rank 1 and rank 2 tensors
       module procedure add_11
       module procedure add_22
       module procedure add_44
       module procedure add_2s2s
       module procedure add_22s
       module procedure add_2s2
       module procedure add_4s4s
       module procedure add_44s
       module procedure add_4s4
       end interface
       interface operator (.add.)
       ! addition of rank 1 and rank 2 tensors
       module procedure add_11
       module procedure add_22
       module procedure add_44
       module procedure add_2s2s
       module procedure add_22s
       module procedure add_2s2
       module procedure add_4s4s
       module procedure add_44s
       module procedure add_4s4
       end interface
       
       interface operator (-)
       ! subtraction of rank 1 and rank 2 tensors
       module procedure sub_11
       module procedure sub_22
       module procedure sub_44
       module procedure sub_2s2s
       module procedure sub_22s
       module procedure sub_2s2
       module procedure sub_4s4s
       module procedure sub_44s
       module procedure sub_4s4
       end interface
       interface operator (.sub.)
       ! subtraction of rank 1 and rank 2 tensors
       module procedure sub_11
       module procedure sub_22
       module procedure sub_44
       module procedure sub_2s2s
       module procedure sub_22s
       module procedure sub_2s2
       module procedure sub_4s4s
       module procedure sub_44s
       module procedure sub_4s4
       end interface
       
       interface operator (.dya.)
       ! dyadic product of rank 2 and rank 4 tensor combinations
       module procedure dyadic_11
       module procedure dyadic_22
       module procedure dyadic_2s2s
       end interface
       
       interface operator (.cdya.)
       ! symmetric crossed dyadic product of rank 2 tensor combinations
       ! (i,j,k,l) = 1/2 * (i,k,j,l)*(i,l,j,k)
       module procedure crossdyadic_22
       module procedure crossdyadic_2s2s
       end interface
       
       interface fact
       module procedure fact_i
       end interface
       
       interface tr
       module procedure tr_2
       module procedure tr_2s
       end interface
       
       interface det
       module procedure det_2
       module procedure det_2s
       end interface
       
       interface dev
       module procedure dev_2
       module procedure dev_2s
       end interface
       
       interface unimodular
       module procedure unimod_2
       module procedure unimod_2s
       module procedure unimod_2d
       module procedure unimod_2sd
       end interface
       
       interface inv
       module procedure inv_2
       module procedure inv_2s
       module procedure inv2d
       module procedure inv2sd
       end interface
       
       interface norm
       module procedure norm_1
       module procedure norm_2
       module procedure norm_2s
       end interface
       
       interface sqrt
       module procedure sqrt_1
       module procedure stretch_2
       module procedure stretch_2s
       end interface
       
       interface dsqrt
       module procedure sqrt_1
       module procedure stretch_2
       module procedure stretch_2s
       end interface
       
       interface rotation_matrix
       module procedure rotation_2
       end interface
       
       interface identity2
       module procedure ident_2
       module procedure ident_2s
       end interface
       
       interface identity4
       module procedure ident_4
       module procedure ident_4s
       end interface
       
       interface tensorstore
       module procedure tenstore_2
       module procedure tenstore_2a
       module procedure tenstore_2s
       module procedure tenstore_4
       module procedure tenstore_4a
       module procedure tenstore_4s
       end interface
       
       interface astensor
       module procedure tenstore_2
       module procedure tenstore_2a
       module procedure tenstore_2s
       module procedure tenstore_4
       module procedure tenstore_4a
       module procedure tenstore_4s
       end interface
       
       interface symstore
       module procedure symstore_2
       module procedure symstore_4
       module procedure symstore_2s
       module procedure symstore_4s
       module procedure symstore_2sa
       module procedure symstore_4sa
       end interface
       
       interface strain
       ! module procedure str2ten_2
       module procedure str2ten_2s
       end interface
       
       interface asvoigt
       module procedure symstore_2
       module procedure symstore_4
       module procedure symstore_2s
       module procedure symstore_4s
       module procedure symstore_2sa
       module procedure symstore_4sa
       end interface
       
       interface voigt
       module procedure symstore_2
       module procedure symstore_4
       module procedure symstore_2s
       module procedure symstore_4s
       module procedure symstore_2sa
       module procedure symstore_4sa
       end interface
       
       interface reduce_dim
       module procedure reduce_dim_2s
       module procedure reduce_dim_4s
       end interface
       
       interface permute
       ! double dot-product of rank 1 and rank 2 tensor combinations
       module procedure permute_2
       module procedure permute_2s
       module procedure permute_4
       module procedure permute_4s
       end interface
       
       interface transpose
       module procedure transp2
       module procedure transp2s
       module procedure transp4
       module procedure transp4s
       end interface
       
       interface piola
       module procedure piola2
       module procedure piola2s
       module procedure piola4
       module procedure piola4s
       end interface
       
       interface asarray
       module procedure asarray_1
       module procedure asarray_2
       module procedure asarray_4
       module procedure asarray_2s
       module procedure asarray_4s
       end interface
       
       interface asabqarray
       module procedure asabqarray_2s
       module procedure asabqarray_4s
       end interface
       
       interface assignment (=)
       module procedure assignscalar_1
       module procedure assignscalar_2
       module procedure assignscalar_2s
       module procedure assignscalar_4
       module procedure assignscalar_4s
       module procedure assignarr_1
       module procedure assignarr_2
       module procedure assignarr_2s
       module procedure assignarr_4
       module procedure assignarr_4s
       module procedure assignten2sym_2
       module procedure assignten2sym_4
       module procedure assignsym2ten_2
       module procedure assignsym2ten_4
       module procedure assignscalar_1r4
       module procedure assignscalar_2r4
       module procedure assignscalar_2sr4
       module procedure assignscalar_4r4
       module procedure assignscalar_4sr4
       module procedure assignarr_2r4
       module procedure assignarr_2sr4
       module procedure assignarr_4r4
       module procedure assignarr_4sr4
       end interface
!      ------END INTERFACE---------------------------------------
       
       contains

!      ------BEGIN FUNCTIONS-------------------------------------
!      ------MATH TOOLS SECTION----------------------------------
       include 'ttb/libtools.f'
!      ------+/- SECTION-----------------------------------------
       include 'ttb/libadd.f'
       include 'ttb/libsub.f'
!      ------DIVISION SECTION------------------------------------
       include 'ttb/libdiv.f'
!      ------DOT SECTION-----------------------------------------
       include 'ttb/libdot.f'
!      ------DOUBLE DOT SECTION----------------------------------
       include 'ttb/libddot.f'
!      ------POWER SECTION---------------------------------------
       include 'ttb/libpower.f'
!      ------DYADIC SECTION--------------------------------------
       include 'ttb/libdyadic.f'
!      ------CROSS-DYADIC SECTION--------------------------------
       include 'ttb/libcrossdyadic.f'
!      ------PERMUTE SECTION-------------------------------------
       include 'ttb/libpermute.f'
!      ------TENSOR FUNCTION SECTION-----------------------------
       include 'ttb/libtransp.f'
       include 'ttb/libtrace.f'
       include 'ttb/libdet.f'
       include 'ttb/libdev.f'
       include 'ttb/libunimodular.f'
       include 'ttb/libinv.f'
       include 'ttb/libnorm.f'
       include 'ttb/libsqrt.f'
       include 'ttb/librotation.f'
!      ------TENSOR INITIALIZATION SECTION-----------------------
       include 'ttb/libidentity.f'
!      ------SYMSTORE SECTION------------------------------------
       include 'ttb/libsymstore.f'
!      ------USYMSTORE SECTION-----------------------------------
       include 'ttb/libtenstore.f'
!      ------STRAINSTORE SECTION---------------------------------
       include 'ttb/libstrainstore.f'
!      ------REDUCE DIM. SECTION---------------------------------
       include 'ttb/libreducedim.f'
!      ------AS ARRAY SECTION------------------------------------
       include 'ttb/libasarray.f'
       include 'ttb/libasabqarray.f'
!      ------PIOLA SECTION---------------------------------------
       include 'ttb/libpiola.f'
!      ------END FUNCTIONS---------------------------------------
!      ------BEGIN SUBROUTINES-----------------------------------
       include 'ttb/libassignscalar.f'
       include 'ttb/libassignarray.f'
       include 'ttb/libassignten2sym.f'

       end module Tensor
