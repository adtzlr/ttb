module ttb_unimodular
   use ttb_types
   use ttb_identity
   use ttb_det
   use ttb_dot
   !use ttb_pow
   interface unimodular
      module procedure unimod_2
      module procedure unimod_2s
      module procedure unimod_2d
      module procedure unimod_2sd
   end interface
contains
   function unimod_2(T)
      implicit none

      type(Tensor2), intent(in) :: T
      type(Tensor2) :: unimod_2, Eye
      real(kind=dp) :: detT

      detT = det(T)
      Eye = identity2(Eye)

      unimod_2 = detT**(-1./3.)*T

   end function unimod_2

   function unimod_2s(T)
      implicit none

      type(Tensor2s), intent(in) :: T
      type(Tensor2s) :: unimod_2s, Eye
      real(kind=dp) :: detT

      detT = det(T)
      Eye = identity2(Eye)

      unimod_2s = detT**(-1./3.)*T

   end function unimod_2s

   function unimod_2d(T, detT)
      implicit none

      type(Tensor2), intent(in) :: T
      type(Tensor2) :: unimod_2d, Eye
      real(kind=dp), intent(in) :: detT

      Eye = identity2(Eye)

      unimod_2d = detT**(-1./3.)*T

   end function unimod_2d

   function unimod_2sd(T, detT)
      implicit none

      type(Tensor2s), intent(in) :: T
      type(Tensor2s) :: unimod_2sd, Eye
      real(kind=dp), intent(in) :: detT

      Eye = identity2(Eye)

      unimod_2sd = detT**(-1./3.)*T

   end function unimod_2sd
end module ttb_unimodular
