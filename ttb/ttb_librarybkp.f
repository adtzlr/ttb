! -----------MODULE TENSOR---------------------------------------
       module Tensor
       ! ---------------------------------------
       ! Tensor Toolbox Module for Fortran
       ! Andreas Dutzler
       ! Graz University of Technology
       ! IME-BST
       ! 2017-11-24
       ! ---------------------------------------
       ! tested on: Windows 7/10 (64bit)
       ! - Intel Fortran 2015
       ! - MinGW gfortran 6.3
       ! ---------------------------------------
       ! use this module in the following form:
       ! ---------------------------------------
       ! include 'ttb'
       ! program sample
       !  use Tensor
       !  ...
       ! end program sample
       ! ---------------------------------------
       
       type Tensor1
        ! tensor of rank 1
        real(kind=8), dimension(3) :: a
       end type Tensor1
       
       type Tensor2
        ! tensor of rank 2
        real(kind=8), dimension(3,3) :: ab
       end type Tensor2
       
       type Tensor2S
        ! symmetric tensor of rank 2 stored as vector
        real(kind=8), dimension(6) :: a6
       end type Tensor2S
       
       type Tensor4
        ! tensor of rank 4
        real(kind=8), dimension(3,3,3,3) :: abcd
       end type Tensor4
       
       type Tensor4S
        ! symmetric tensor of rank 4 stored as 6x6 matrix
        real(kind=8), dimension(6, 6) :: a6b6
       end type Tensor4S

!      ------BEGIN INTERFACE-------------------------------------
       interface operator (/)
       module procedure div_10
       module procedure div_10_r4
       module procedure div_20
       module procedure div_20_r4
       module procedure div_20s
       module procedure div_20s_r4
       module procedure div_40
       module procedure div_40_r4
       module procedure div_40s
       module procedure div_40s_r4
       end interface
       interface operator (.div.)
       module procedure div_10
       module procedure div_10_r4
       module procedure div_20
       module procedure div_20_r4
       module procedure div_20s
       module procedure div_20s_r4
       module procedure div_40
       module procedure div_40_r4
       module procedure div_40s
       module procedure div_40s_r4
       end interface
       
       interface operator (*)
       ! simple dot-product of rank 1 and rank 2 tensor combinations
       module procedure dot_01
       module procedure dot_01_r4
       module procedure dot_10
       module procedure dot_10_r4
       module procedure dot_02
       module procedure dot_02_r4
       module procedure dot_02s
       module procedure dot_02s_r4
       module procedure dot_20
       module procedure dot_20_r4
       module procedure dot_20s
       module procedure dot_20s_r4
       module procedure dot_04
       module procedure dot_04_r4
       module procedure dot_04s
       module procedure dot_04s_r4
       module procedure dot_40
       module procedure dot_40_r4
       module procedure dot_40s
       module procedure dot_40s_r4
       module procedure dot_12
       module procedure dot_21
       module procedure dot_22
       module procedure dot_2s2s
       end interface
       interface operator (.dot.)
       ! simple dot-product of rank 1 and rank 2 tensor combinations
       module procedure dot_01
       module procedure dot_01_r4
       module procedure dot_10
       module procedure dot_10_r4
       module procedure dot_02
       module procedure dot_02_r4
       module procedure dot_02s
       module procedure dot_02s_r4
       module procedure dot_20
       module procedure dot_20_r4
       module procedure dot_20s
       module procedure dot_20s_r4
       module procedure dot_04
       module procedure dot_04_r4
       module procedure dot_04s
       module procedure dot_04s_r4
       module procedure dot_40
       module procedure dot_40_r4
       module procedure dot_40s
       module procedure dot_40s_r4
       module procedure dot_12
       module procedure dot_21
       module procedure dot_22
       module procedure dot_2s2s
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
       
       interface operator (+)
       ! addition of rank 1 and rank 2 tensors
       module procedure add_11
       module procedure add_22
       module procedure add_44
       module procedure add_2s2s
       module procedure add_4s4s
       end interface
       interface operator (.add.)
       ! addition of rank 1 and rank 2 tensors
       module procedure add_11
       module procedure add_22
       module procedure add_44
       module procedure add_2s2s
       module procedure add_4s4s
       end interface
       
       interface operator (-)
       ! subtraction of rank 1 and rank 2 tensors
       module procedure sub_11
       module procedure sub_22
       module procedure sub_44
       module procedure sub_2s2s
       module procedure sub_4s4s
       end interface
       interface operator (.sub.)
       ! subtraction of rank 1 and rank 2 tensors
       module procedure sub_11
       module procedure sub_22
       module procedure sub_44
       module procedure sub_2s2s
       module procedure sub_4s4s
       end interface
       
       interface operator (.dyadic.)
       ! dyadic product of rank 2 and rank 4 tensor combinations
       module procedure dyadic_11
       module procedure dyadic_22
       module procedure dyadic_2s2s
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
       
       interface inv
       module procedure inv_2
       module procedure inv_2s
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
       ! module procedure tenstore_4
       end interface
       
       interface symstore
       module procedure symstore_2
       module procedure symstore_4
       end interface
       
       interface reduce_dim
       module procedure reduce_dim_2s
       module procedure reduce_dim_4s
       end interface
       
       interface permute
       ! double dot-product of rank 1 and rank 2 tensor combinations
       module procedure permute_2
       module procedure permute_4
       end interface
       
       interface transpose
       ! double dot-product of rank 1 and rank 2 tensor combinations
       module procedure transp2
       module procedure transp4
       module procedure transp4s
       end interface
!      ------END INTERFACE---------------------------------------
       
       contains

!      ------BEGIN FUNCTIONS-------------------------------------
!      ------+/- SECTION-----------------------------------------
       function add_11(T1, T2)
        implicit none
        
        type(Tensor1), intent(in) :: T1, T2
        type(Tensor1) :: add_11

        add_11%a = T1%a + T2%a
        
       end function add_11
       
       function add_22(T1, T2)
        implicit none
        
        type(Tensor2), intent(in) :: T1, T2
        type(Tensor2) :: add_22

        add_22%ab = T1%ab + T2%ab
        
       end function add_22
       
       function add_2s2s(T1, T2)
        implicit none
        
        type(Tensor2s), intent(in) :: T1, T2
        type(Tensor2s) :: add_2s2s

        add_2s2s%a6 = T1%a6 + T2%a6
        
       end function add_2s2s
       
       function add_44(T1, T2)
        implicit none
        
        type(Tensor4), intent(in) :: T1, T2
        type(Tensor4) :: add_44

        add_44%abcd = T1%abcd + T2%abcd
        
       end function add_44
       
       function add_4s4s(T1, T2)
        implicit none
        
        type(Tensor4s), intent(in) :: T1, T2
        type(Tensor4s) :: add_4s4s

        add_4s4s%a6b6 = T1%a6b6 + T2%a6b6
        
       end function add_4s4s
       
       function sub_11(T1, T2)
        implicit none
        
        type(Tensor1), intent(in) :: T1, T2
        type(Tensor1) :: sub_11

        sub_11%a = T1%a - T2%a
        
       end function sub_11
       
       function sub_22(T1, T2)
        implicit none
        
        type(Tensor2), intent(in) :: T1, T2
        type(Tensor2) :: sub_22

        sub_22%ab = T1%ab - T2%ab
        
       end function sub_22
       
       function sub_2s2s(T1, T2)
        implicit none
        
        type(Tensor2s), intent(in) :: T1, T2
        type(Tensor2s) :: sub_2s2s

        sub_2s2s%a6 = T1%a6 - T2%a6
        
       end function sub_2s2s
       
       function sub_44(T1, T2)
        implicit none
        
        type(Tensor4), intent(in) :: T1, T2
        type(Tensor4) :: sub_44

        sub_44%abcd = T1%abcd - T2%abcd
        
       end function sub_44
       
       function sub_4s4s(T1, T2)
        implicit none
        
        type(Tensor4s), intent(in) :: T1, T2
        type(Tensor4s) :: sub_4s4s

        sub_4s4s%a6b6 = T1%a6b6 - T2%a6b6
        
       end function sub_4s4s
!      ------DIVISION SECTION----------------------------------
!      ------REAL(KIND=8)--------------------------------------
       function div_10(T, w)
        implicit none
        
        real(kind=8), intent(in) :: w
        type(Tensor1), intent(in) :: T
        type(Tensor1) :: div_10

        div_10%a = T%a / w
        
       end function div_10
       
       function div_20(T, w)
        implicit none
        
        real(kind=8), intent(in) :: w
        type(Tensor2), intent(in) :: T
        type(Tensor2) :: div_20

        div_20%ab = T%ab / w
        
       end function div_20
       
       function div_20s(T, w)
        implicit none
        
        real(kind=8), intent(in) :: w
        type(Tensor2s), intent(in) :: T
        type(Tensor2s) :: div_20s

        div_20s%a6 = T%a6 / w
        
       end function div_20s

       function div_40(T, w)
        implicit none
        
        real(kind=8), intent(in) :: w
        type(Tensor4), intent(in) :: T
        type(Tensor4) :: div_40

        div_40%abcd = T%abcd / w
        
       end function div_40
       
       function div_40s(T, w)
        implicit none
        
        real(kind=8), intent(in) :: w
        type(Tensor4s), intent(in) :: T
        type(Tensor4s) :: div_40s

        div_40s%a6b6 = T%a6b6 / w
        
       end function div_40s
!      ------REAL(KIND=4)----------------------------------------
       function div_10_r4(T, w)
        implicit none
        
        real, intent(in) :: w
        type(Tensor1), intent(in) :: T
        type(Tensor1) :: div_10_r4

        div_10_r4%a = T%a / dble(w)
        
       end function div_10_r4
       
       function div_20_r4(T, w)
        implicit none
        
        real, intent(in) :: w
        type(Tensor2), intent(in) :: T
        type(Tensor2) :: div_20_r4

        div_20_r4%ab = T%ab / dble(w)
        
       end function div_20_r4
       
       function div_20s_r4(T, w)
        implicit none
        
        real, intent(in) :: w
        type(Tensor2s), intent(in) :: T
        type(Tensor2s) :: div_20s_r4

        div_20s_r4%a6 = T%a6 / dble(w)
        
       end function div_20s_r4

       function div_40_r4(T, w)
        implicit none
        
        real, intent(in) :: w
        type(Tensor4), intent(in) :: T
        type(Tensor4) :: div_40_r4

        div_40_r4%abcd = T%abcd / dble(w)
        
       end function div_40_r4
       
       function div_40s_r4(T, w)
        implicit none
        
        real, intent(in) :: w
        type(Tensor4s), intent(in) :: T
        type(Tensor4s) :: div_40s_r4

        div_40s_r4%a6b6 = T%a6b6 / dble(w)
        
       end function div_40s_r4
!      ------DOT SECTION-----------------------------------------
!      ------SIMPLE DOT SECTION----------------------------------
!      ------REAL(KIND=8)----------------------------------------
       function dot_01(w, T)
        implicit none
        
        real(kind=8), intent(in) :: w
        type(Tensor1), intent(in) :: T
        type(Tensor1) :: dot_01

        dot_01%a = w * T%a
        
       end function dot_01
       
       function dot_10(T, w)
        implicit none
        
        real(kind=8), intent(in) :: w
        type(Tensor1), intent(in) :: T
        type(Tensor1) :: dot_10

        dot_10%a = w * T%a
        
       end function dot_10
       
       function dot_02(w, T)
        implicit none
        
        real(kind=8), intent(in) :: w
        type(Tensor2), intent(in) :: T
        type(Tensor2) :: dot_02

        dot_02%ab = w * T%ab
        
       end function dot_02
       
       function dot_02s(w, T)
        implicit none
        
        real(kind=8), intent(in) :: w
        type(Tensor2s), intent(in) :: T
        type(Tensor2s) :: dot_02s

        dot_02s%a6 = w * T%a6
        
       end function dot_02s
       
       function dot_20(T, w)
        implicit none
        
        real(kind=8), intent(in) :: w
        type(Tensor2), intent(in) :: T
        type(Tensor2) :: dot_20

        dot_20%ab = w * T%ab
        
       end function dot_20
       
       function dot_20s(T, w)
        implicit none
        
        real(kind=8), intent(in) :: w
        type(Tensor2s), intent(in) :: T
        type(Tensor2s) :: dot_20s

        dot_20s%a6 = w * T%a6
        
       end function dot_20s
       
       function dot_04(w, T)
        implicit none
        
        real(kind=8), intent(in) :: w
        type(Tensor4), intent(in) :: T
        type(Tensor4) :: dot_04

        dot_04%abcd = w * T%abcd
        
       end function dot_04
       
       function dot_04s(w, T)
        implicit none
        
        real(kind=8), intent(in) :: w
        type(Tensor4s), intent(in) :: T
        type(Tensor4s) :: dot_04s

        dot_04s%a6b6 = w * T%a6b6
        
       end function dot_04s
       
       function dot_40(T, w)
        implicit none
        
        real(kind=8), intent(in) :: w
        type(Tensor4), intent(in) :: T
        type(Tensor4) :: dot_40

        dot_40%abcd = w * T%abcd
        
       end function dot_40
       
       function dot_40s(T, w)
        implicit none
        
        real(kind=8), intent(in) :: w
        type(Tensor4s), intent(in) :: T
        type(Tensor4s) :: dot_40s

        dot_40s%a6b6 = w * T%a6b6
        
       end function dot_40s
!      ------REAL(KIND=4)----------------------------------------
       function dot_01_r4(w, T)
        implicit none
        
        real, intent(in) :: w
        type(Tensor1), intent(in) :: T
        type(Tensor1) :: dot_01_r4

        dot_01_r4%a = dble(w) * T%a
        
       end function dot_01_r4
       
       function dot_10_r4(T, w)
        implicit none
        
        real, intent(in) :: w
        type(Tensor1), intent(in) :: T
        type(Tensor1) :: dot_10_r4

        dot_10_r4%a = dble(w) * T%a
        
       end function dot_10_r4
       
       function dot_02_r4(w, T)
        implicit none
        
        real, intent(in) :: w
        type(Tensor2), intent(in) :: T
        type(Tensor2) :: dot_02_r4

        dot_02_r4%ab = dble(w) * T%ab
        
       end function dot_02_r4
       
       function dot_02s_r4(w, T)
        implicit none
        
        real, intent(in) :: w
        type(Tensor2s), intent(in) :: T
        type(Tensor2s) :: dot_02s_r4

        dot_02s_r4%a6 = dble(w) * T%a6
        
       end function dot_02s_r4
       
       function dot_20_r4(T, w)
        implicit none
        
        real, intent(in) :: w
        type(Tensor2), intent(in) :: T
        type(Tensor2) :: dot_20_r4

        dot_20_r4%ab = dble(w) * T%ab
        
       end function dot_20_r4
       
       function dot_20s_r4(T, w)
        implicit none
        
        real, intent(in) :: w
        type(Tensor2s), intent(in) :: T
        type(Tensor2s) :: dot_20s_r4

        dot_20s_r4%a6 = dble(w) * T%a6
        
       end function dot_20s_r4
       
       function dot_04_r4(w, T)
        implicit none
        
        real, intent(in) :: w
        type(Tensor4), intent(in) :: T
        type(Tensor4) :: dot_04_r4

        dot_04_r4%abcd = dble(w) * T%abcd
        
       end function dot_04_r4
       
       function dot_04s_r4(w, T)
        implicit none
        
        real, intent(in) :: w
        type(Tensor4s), intent(in) :: T
        type(Tensor4s) :: dot_04s_r4

        dot_04s_r4%a6b6 = dble(w) * T%a6b6
        
       end function dot_04s_r4
       
       function dot_40_r4(T, w)
        implicit none
        
        real, intent(in) :: w
        type(Tensor4), intent(in) :: T
        type(Tensor4) :: dot_40_r4

        dot_40_r4%abcd = dble(w) * T%abcd
        
       end function dot_40_r4
       
       function dot_40s_r4(T, w)
        implicit none
        
        real, intent(in) :: w
        type(Tensor4s), intent(in) :: T
        type(Tensor4s) :: dot_40s_r4

        dot_40s_r4%a6b6 = dble(w) * T%a6b6
        
       end function dot_40s_r4
       
!      ------REAL(KIND=8)----------------------------------------
       function dot_21(T1, T2)
        implicit none
        
        type(Tensor2), intent(in) :: T1
        type(Tensor1), intent(in) :: T2
        type(Tensor1) :: dot_21
        integer :: i, j
        
        do i = 1,3
         dot_21%a(i) = 0.d0
         do j = 1,3
          dot_21%a(i) = dot_21%a(i) + T1%ab(i,j)*T2%a(i)
         enddo
        enddo
        
       end function dot_21
       
       function dot_12(T1, T2)
        implicit none
        
        type(Tensor1), intent(in) :: T1
        type(Tensor2), intent(in) :: T2
        type(Tensor1) :: dot_12
        integer :: i, j
        
        do i = 1,3
         dot_12%a(j) = 0.d0
         do j = 1,3
          dot_12%a(j) = dot_12%a(j) + T1%a(i)*T2%ab(i,j)
         enddo
        enddo
        
       end function dot_12
       
       function dot_22(T1, T2)
        implicit none
        
        type(Tensor2), intent(in) :: T1
        type(Tensor2), intent(in) :: T2
        type(Tensor2) :: dot_22
        integer :: i,j,k
        
        dot_22%ab = 0.d0
        do i = 1,3
         do j = 1,3
          do k = 1,3
           dot_22%ab(i,j) = dot_22%ab(i,j) + T1%ab(i,k)*T2%ab(k,j)
          enddo
         enddo
        enddo
       end function dot_22
       
       function dot_2s2s(T1, T2)
        implicit none
        
        type(Tensor2s), intent(in) :: T1
        type(Tensor2s), intent(in) :: T2
        type(Tensor2s) :: dot_2s2s
        
        dot_2s2s%a6(1) = T1%a6(1)*T2%a6(1)+T1%a6(4)*T2%a6(4)
     *                  +T1%a6(6)*T2%a6(6)
        dot_2s2s%a6(2) = T1%a6(2)*T2%a6(2)+T1%a6(4)*T2%a6(4)
     *                  +T1%a6(5)*T2%a6(5)
        dot_2s2s%a6(3) = T1%a6(3)*T2%a6(3)+T1%a6(5)*T2%a6(5)
     *                  +T1%a6(6)*T2%a6(6)
        dot_2s2s%a6(4) = T1%a6(1)*T2%a6(4)+T1%a6(4)*T2%a6(2)
     *                  +T1%a6(6)*T2%a6(5)
        dot_2s2s%a6(5) = T1%a6(4)*T2%a6(6)+T1%a6(2)*T2%a6(5)
     *                  +T1%a6(5)*T2%a6(3)
        dot_2s2s%a6(6) = T1%a6(6)*T2%a6(1)+T1%a6(5)*T2%a6(4)
     *                  +T1%a6(3)*T2%a6(6)
       end function dot_2s2s
!      ------DOUBLE DOT SECTION----------------------------------
       function ddot_22(T1, T2)
        implicit none
        
        type(Tensor2), intent(in) :: T1
        type(Tensor2), intent(in) :: T2
        real(kind=8) :: ddot_22
        integer :: i,j
        
        ddot_22 = 0.d0
        do i = 1,3
         do j = 1,3
          ddot_22 = ddot_22 + T1%ab(i,j)*T2%ab(i,j)
         enddo
        enddo
        
       end function ddot_22
       
       function ddot_2s2s(T1, T2)
        implicit none
        
        type(Tensor2s), intent(in) :: T1
        type(Tensor2s), intent(in) :: T2
        real(kind=8) :: ddot_2s2s
        integer :: i
        
        ddot_2s2s = 0.d0
        do i=1,6
         ddot_2s2s = ddot_2s2s + T1%a6(i)*T2%a6(i)
        enddo
        
       end function ddot_2s2s
       
       function ddot_24(T1, T2)
        implicit none
        
        type(Tensor2), intent(in) :: T1
        type(Tensor4), intent(in) :: T2
        type(Tensor2) :: ddot_24
        integer :: i,j,k,l
        
        ddot_24%ab = 0.d0
        do i = 1,3
         do j = 1,3
          do k = 1,3
           do l = 1,3
            ddot_24%ab(k,l) = ddot_24%ab(k,l)
     *          + T1%ab(i,j)*T2%abcd(i,j,k,l)
           enddo
          enddo
         enddo
        enddo
        
       end function ddot_24
       
       function ddot_2s4s(T1, T2)
        implicit none
        
        type(Tensor2s), intent(in) :: T1
        type(Tensor4s), intent(in) :: T2
        type(Tensor2s) :: ddot_2s4s
        integer :: i,j
        
        ddot_2s4s%a6 = 0.d0
        do i = 1,6
         do j = 1,6
          ddot_2s4s%a6(j) = ddot_2s4s%a6(j)
     *              + T1%a6(i)*T2%a6b6(i,j)
         enddo
        enddo
        
       end function ddot_2s4s
       
       function ddot_42(T1, T2)
        implicit none
        
        type(Tensor4), intent(in) :: T1
        type(Tensor2), intent(in) :: T2
        type(Tensor2) :: ddot_42
        integer :: i,j,k,l
        
        ddot_42%ab = 0.d0
        do i = 1,3
         do j = 1,3
          do k = 1,3
           do l = 1,3
            ddot_42%ab(i,j) = ddot_42%ab(i,j)
     *          + T1%abcd(i,j,k,l)*T2%ab(k,l)
           enddo
          enddo
         enddo
        enddo
        
       end function ddot_42
       
       function ddot_4s2s(T1, T2)
        implicit none
        
        type(Tensor4s), intent(in) :: T1
        type(Tensor2s), intent(in) :: T2
        type(Tensor2s) :: ddot_4s2s
        integer :: i,j
        
        ddot_4s2s%a6 = 0.d0
        do i = 1,6
         do j = 1,6
          ddot_4s2s%a6(i) = ddot_4s2s%a6(i)
     *          + T1%a6b6(i,j)*T2%a6(j)
         enddo
        enddo
        
       end function ddot_4s2s
       
       function ddot_44(T1, T2)
        implicit none
        
        type(Tensor4), intent(in) :: T1
        type(Tensor4), intent(in) :: T2
        type(Tensor4) :: ddot_44
        integer :: i,j,k,l,m,n
        
        ddot_44%abcd = 0.d0
        do i = 1,3
         do j = 1,3
          do m = 1,3
           do n = 1,3
            do k = 1,3
             do l = 1,3
              ddot_44%abcd(i,j,k,l) = ddot_44%abcd(i,j,k,l)
     *           + T1%abcd(i,j,m,n)*T2%abcd(m,n,k,l)
             enddo
            enddo
           enddo
          enddo
         enddo
        enddo
       end function ddot_44
        
       function ddot_4s4s(T1, T2)
        implicit none
        
        type(Tensor4s), intent(in) :: T1
        type(Tensor4s), intent(in) :: T2
        type(Tensor4s) :: ddot_4s4s
        integer :: i,j,k,l
        
        ddot_4s4s%a6b6 = 0.d0
        do i = 1,6
         do k = 1,6
          do j = 1,6
           ddot_4s4s%a6b6(i,j) = ddot_4s4s%a6b6(i,j)
     *           + T1%a6b6(i,k)*T2%a6b6(k,j)
          enddo
         enddo
        enddo
        
       end function ddot_4s4s
!      ------DYADIC SECTION--------------------------------------
       function dyadic_11(T1, T2)
        implicit none
        
        type(Tensor1), intent(in) :: T1, T2
        type(Tensor2) :: dyadic_11
        integer i, j
        
        forall(i=1:3,j=1:3) dyadic_11%ab(i,j) = T1%a(i) * T2%a(j)
        
       end function dyadic_11
       
       function dyadic_22(T1, T2)
        implicit none
        
        type(Tensor2), intent(in) :: T1, T2
        type(Tensor4) :: dyadic_22
        integer i, j, k, l
        
        forall(i=1:3,j=1:3,k=1:3,l=1:3) dyadic_22%abcd(i,j,k,l)
     *                                = T1%ab(i,j) * T2%ab(k,l)
        
       end function dyadic_22
       
       function dyadic_2s2s(T1, T2)
        implicit none
        
        type(Tensor2s), intent(in) :: T1, T2
        type(Tensor4s) :: dyadic_2s2s
        integer i, j
        
        forall(i=1:6,j=1:6) dyadic_2s2s%a6b6(i,j) = T1%a6(i) * T2%a6(j)
        
       end function dyadic_2s2s
!      ------PERMUTE SECTION-------------------------------------
       function permute_2(T,i1,j1)
        ! permute tensor of rank 2 for orders 2,1 = transpose(T)
        implicit none
        
        type(Tensor2), intent(in) :: T
        integer, intent(in) :: i1,j1
        
        type(Tensor2) :: permute_2
        
        permute_2%ab = transpose(T%ab)
        
       end function permute_2
       
       function permute_4(T,i1,j1,k1,l1)
        ! permute tensor of rank 4 for orders 1,3,2,4 or 1,4,2,3
        implicit none
        
        type(Tensor4), intent(in) :: T
        integer, intent(in) :: i1,j1,k1,l1
        
        type(Tensor4) :: permute_4
        integer i,j,k,l
        
        if (i1==1 .and. j1==3 .and. k1==2 .and. l1==4) then
         forall(i=1:3,j=1:3,k=1:3,l=1:3) permute_4%abcd(i,j,k,l)
     *                                         = T%abcd(i,k,j,l)
        else if (i1==1 .and. j1==4 .and. k1==2 .and. l1==3) then
         forall(i=1:3,j=1:3,k=1:3,l=1:3) permute_4%abcd(i,j,k,l)
     *                                         = T%abcd(i,l,j,k)
        else
         permute_4%abcd = T%abcd
        end if
        
        ! permute_4%abcd = reshape(T%abcd, (/i1,j1,k1,l1/))
        
       end function permute_4
!      ------TENSOR FUNCTION SECTION-----------------------------
       function transp2(T)
        implicit none
        
        type(Tensor2), intent(in) :: T
        type(Tensor2) :: transp2
        
        transp2%ab = transpose(T%ab)
        
       end function transp2
       
       function transp4(T)
        implicit none
        
        type(Tensor4), intent(in) :: T
        type(Tensor4) :: transp4
        integer :: i,j,k,l
        
        transp4%abcd = 0.d0
        forall (i=1:3,j=1:3,k=1:3,l=1:3) transp4%abcd(i,j,k,l) 
     *                                 = transp4%abcd(k,l,i,j)
        
       end function transp4
       
       function transp4s(T)
        implicit none
        
        type(Tensor4s), intent(in) :: T
        type(Tensor4s) :: transp4s
        
        transp4s%a6b6 = transpose(T%a6b6)
        
       end function transp4s
       
       function tr_2(T)
        implicit none
        
        type(Tensor2) :: T
        real(kind=8) :: tr_2
        
        tr_2 = T%ab(1,1)+T%ab(2,2)+T%ab(3,3)
        
       end function tr_2
       
       function tr_2s(T)
        implicit none
        
        type(Tensor2s) :: T
        real(kind=8) :: tr_2s
        
        tr_2s = T%a6(1)+T%a6(2)+T%a6(3)
        
       end function tr_2s
       
       function det_2(T)
        implicit none
        
        type(Tensor2) :: T
        real(kind=8) :: det_2
        
        det_2 = T%ab(1,1)*(T%ab(2,2)*T%ab(3,3)-T%ab(2,3)*T%ab(3,2))
     *      + T%ab(1,2)*(T%ab(2,3)*T%ab(3,1)-T%ab(2,1)*T%ab(3,3))
     *      + T%ab(1,3)*(T%ab(2,1)*T%ab(3,2)-T%ab(2,2)*T%ab(3,1))
     
       end function det_2
       
       function det_2s(T)
        implicit none
        
        type(Tensor2s) :: T
        real(kind=8) :: det_2s
        
        det_2s = T%a6(1)*T%a6(2)*T%a6(3) + 2.d0*T%a6(4)*T%a6(5)*T%a6(6)
     *         - T%a6(2)*T%a6(4)*T%a6(6) -      T%a6(1)*T%a6(5)*T%a6(6)
     *         - T%a6(3)*T%a6(4)*T%a6(5)
       
       end function det_2s
       
       function dev_2(T)
        implicit none
        
        type(Tensor2), intent(in) :: T
        type(Tensor2) :: dev_2,Eye
        
        Eye = identity2(Eye)
        dev_2%ab = T%ab - tr(T)/3.d0*Eye%ab
     
       end function dev_2
       
       function dev_2s(T)
        implicit none
        
        type(Tensor2s), intent(in) :: T
        type(Tensor2s) :: dev_2s,Eye
        
        Eye = identity2(Eye)
        dev_2s%a6 = T%a6 - tr(T)/3.d0*Eye%a6
     
       end function dev_2s

       function inv_2(T)
        implicit none
        
        type(Tensor2), intent(in) :: T
        type(Tensor2) :: inv_2
        real(kind=8) :: detT
        
        detT = det(T)
        
        inv_2%ab(1,1)=+1./detT*(T%ab(2,2)*T%ab(3,3)-T%ab(2,3)*T%ab(3,2))
        inv_2%ab(2,1)=-1./detT*(T%ab(2,1)*T%ab(3,3)-T%ab(2,3)*T%ab(3,1))
        inv_2%ab(3,1)=+1./detT*(T%ab(2,1)*T%ab(3,2)-T%ab(2,2)*T%ab(3,1))
        inv_2%ab(1,2)=-1./detT*(T%ab(1,2)*T%ab(3,3)-T%ab(1,3)*T%ab(3,2))
        inv_2%ab(2,2)=+1./detT*(T%ab(1,1)*T%ab(3,3)-T%ab(1,3)*T%ab(3,1))
        inv_2%ab(3,2)=-1./detT*(T%ab(1,1)*T%ab(3,2)-T%ab(1,2)*T%ab(3,1))
        inv_2%ab(1,3)=+1./detT*(T%ab(1,2)*T%ab(2,3)-T%ab(1,3)*T%ab(2,2))
        inv_2%ab(2,3)=-1./detT*(T%ab(1,1)*T%ab(2,3)-T%ab(1,3)*T%ab(2,1))
        inv_2%ab(3,3)=+1./detT*(T%ab(1,1)*T%ab(2,2)-T%ab(1,2)*T%ab(2,1))
        
       end function inv_2
       
       function inv_2s(T)
        implicit none
        
        type(Tensor2s), intent(in) :: T
        type(Tensor2s) :: inv_2s
        real(kind=8) :: detT
        
        detT = det(T)
        
        inv_2s%a6(1)=+1./detT*(T%a6(2)*T%a6(3)-T%a6(5)*T%a6(5))
        inv_2s%a6(4)=-1./detT*(T%a6(4)*T%a6(3)-T%a6(5)*T%a6(6))
        inv_2s%a6(6)=+1./detT*(T%a6(4)*T%a6(5)-T%a6(2)*T%a6(6))
        inv_2s%a6(2)=+1./detT*(T%a6(1)*T%a6(3)-T%a6(6)*T%a6(6))
        inv_2s%a6(5)=-1./detT*(T%a6(1)*T%a6(5)-T%a6(4)*T%a6(6))
        inv_2s%a6(3)=+1./detT*(T%a6(1)*T%a6(2)-T%a6(4)*T%a6(4))
        
       end function inv_2s
!      ------TENSOR INITIALIZATION SECTION-----------------------
       function ident_2(T)
        implicit none
        
        type(Tensor2), intent(in) :: T
        type(Tensor2) :: ident_2
        integer :: i
        
        ident_2%ab = 0.d0
        do i = 1,3
         ident_2%ab(i,i) = 1.d0
        enddo
        
       end function ident_2
       
       function ident_2s(T)
        implicit none
        
        type(Tensor2s), intent(in) :: T
        type(Tensor2s) :: ident_2s
        integer :: i
        
        ident_2s%a6 = 0.d0
        do i = 1,3
         ident_2s%a6(i) = 1.d0
        enddo
        
       end function ident_2s
       
       function ident_4(T)
        implicit none
        
        type(Tensor2), intent(in) :: T
        type(Tensor4) :: ident_4
        integer :: i,j,k,l
        
        ident_4%abcd = 0.d0
        forall(i=1:3,j=1:3,k=1:3,l=1:3) ident_4%abcd(i,j,k,l) = 
     *       1./2.*(T%ab(i,k)*T%ab(j,l)+T%ab(i,l)*T%ab(j,k))
        
       end function ident_4
       
       function ident_4s(T)
        implicit none
        
        type(Tensor2s), intent(in) :: T
        type(Tensor4s) :: ident_4s
        integer :: i,j
        
        ident_4s%a6b6 = 0.d0
        do i=1,3
         ident_4s%a6b6(i,i) = 1.d0
        enddo
        
       end function ident_4s
!      ------SYMSTORE SECTION------------------------------------
       function symstore_2(T,w)
        implicit none
        
        integer, intent(in) :: w
        type(Tensor2), intent(in) :: T
        type(Tensor2s) :: symstore_2
        integer :: i
        
        symstore_2%a6 = 0.d0
        do i=1,3
         symstore_2%a6(i) = T%ab(i,i)
        enddo
        symstore_2%a6(4) = dble(w)*T%ab(1,2)
        symstore_2%a6(5) = dble(w)*T%ab(2,3)
        symstore_2%a6(6) = dble(w)*T%ab(3,1)

       end function symstore_2
       
       function symstore_4(T)
        implicit none
        
        type(Tensor4), intent(in) :: T
        type(Tensor4s) :: symstore_4
        integer :: i,j
        
        symstore_4%a6b6 = 0.d0
        do i=1,3
         do j=1,3
          symstore_4%a6b6(i,j) = T%abcd(i,i,j,j)
         enddo
        enddo
        
        symstore_4%a6b6(4,4) = 2.*T%abcd(1,2,1,2)
        symstore_4%a6b6(5,5) = 2.*T%abcd(2,3,2,3)
        symstore_4%a6b6(6,6) = 2.*T%abcd(3,1,3,1)
        
        do i=1,3
         symstore_4%a6b6(i,4) = 2.*T%abcd(i,i,1,2)
         symstore_4%a6b6(i,5) = 2.*T%abcd(i,i,2,3)
         symstore_4%a6b6(i,6) = 2.*T%abcd(i,i,3,1)
        enddo
        
        symstore_4%a6b6(4,5) = 2.*T%abcd(1,2,2,3)
        symstore_4%a6b6(4,6) = 2.*T%abcd(1,2,3,1)
        
        symstore_4%a6b6(5,4) = 2.*T%abcd(2,3,1,2)
        symstore_4%a6b6(5,6) = 2.*T%abcd(2,3,3,1)
        
        symstore_4%a6b6(6,4) = 2.*T%abcd(3,1,1,2)
        symstore_4%a6b6(6,5) = 2.*T%abcd(3,1,2,3)
        
       end function symstore_4
!      ------USYMSTORE SECTION-----------------------------------
       function tenstore_2(T,w)
        implicit none
        
        integer, intent(in) :: w
        type(Tensor2s), intent(in) :: T
        type(Tensor2) :: tenstore_2
        integer :: i
        
        tenstore_2%ab = 0.d0
        do i=1,3
         tenstore_2%ab(i,i) = T%a6(i)
        enddo
        tenstore_2%ab(1,2) = T%a6(4)/dble(w)
        tenstore_2%ab(2,3) = T%a6(5)/dble(w)
        tenstore_2%ab(3,1) = T%a6(6)/dble(w)
        tenstore_2%ab(2,1) = tenstore_2%ab(1,2)
        tenstore_2%ab(3,2) = tenstore_2%ab(2,3)
        tenstore_2%ab(1,3) = tenstore_2%ab(3,1)

       end function tenstore_2
!      ------REDUCE DIM. SECTION---------------------------------
       function reduce_dim_2s(T,i)
        implicit none
        
        type(Tensor2s), intent(in) :: T
        integer, intent(in) :: i
        real(kind=8), dimension(i) :: reduce_dim_2s
        
        reduce_dim_2s = T%a6(1:i)
        
       end function reduce_dim_2s
       
       function reduce_dim_4s(T,i,j)
        implicit none
        
        type(Tensor4s), intent(in) :: T
        integer, intent(in) :: i,j
        real(kind=8), dimension(i,j) :: reduce_dim_4s
        
        reduce_dim_4s = T%a6b6(1:i,1:j)
        
       end function reduce_dim_4s
!      ------END FUNCTIONS---------------------------------------

       end module Tensor