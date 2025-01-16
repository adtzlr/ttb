module ttb_types
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
   integer, parameter :: dp = selected_real_kind(15)

   type Tensor1
      ! tensor of rank 1
      real(kind=dp), dimension(3) :: a = 0.d0
   end type Tensor1

   type Tensor2
      ! tensor of rank 2
      real(kind=dp), dimension(3, 3) :: ab = 0.d0
   end type Tensor2

   type Tensor2S
      ! symmetric tensor of rank 2 stored as vector
      real(kind=dp), dimension(6) :: a6 = 0.d0
   end type Tensor2S

   type Tensor4
      ! tensor of rank 4
      real(kind=dp), dimension(3, 3, 3, 3) :: abcd = 0.d0
   end type Tensor4

   type Tensor4S
      ! symmetric tensor of rank 4 stored as 6x6 matrix
      real(kind=dp), dimension(6, 6) :: a6b6 = 0.d0
   end type Tensor4S

end module ttb_types
