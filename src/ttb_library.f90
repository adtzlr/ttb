! ---------------------------------------
! Tensor Toolbox Module for Fortran
! Andreas Dutzler
! Graz University of Technology
! Institute of Structural Durability
!    and Railway Technology
! ---------------------------------------
! -----------MODULE TENSOR---------------------------------------
module Tensor
   use ttb_types
   use ttb_add
   use ttb_asabqarray
   use ttb_asarray
   use ttb_assign
   use ttb_cdya
   use ttb_dot
   use ttb_ddot
   use ttb_det
   use ttb_dev
   use ttb_div
   use ttb_dya
   use ttb_identity
   use ttb_inv
   use ttb_norm
   use ttb_permute
   use ttb_piola
   use ttb_pow
   use ttb_reduce_dim
   use ttb_rotation
   use ttb_sqrt
   use ttb_strainstore
   use ttb_sub
   use ttb_symstore
   use ttb_tensorstore
   use ttb_fact
   use ttb_trace
   use ttb_transpose
   use ttb_unimodular

   ! tested on: Windows 10 (64bit)
   ! - Intel Fortran >2015
   ! - MinGW gfortran >6.3
   ! ---------------------------------------
   ! use this module in the following form:
   ! ---------------------------------------
   ! program sample
   !  use Tensor
   !  ...
   ! end program sample
   ! ---------------------------------------
contains

   subroutine print_banner()
      implicit none
      print *, " "
      print *, "---------------------------------------"
      print *, " Tensor Toolbox Module for Fortran"
      print *, "         Andreas Dutzler"
      print *, "   Graz University of Technology"
      print *, " Institute of Structural Durability"
      print *, "       and Railway Technology"
      print *, "---------------------------------------"
      print *, " "
   end subroutine print_banner

end module Tensor
