module ttb_identity
   use ttb_types
   use ttb_cdya
   interface identity2
      module procedure ident_2
      module procedure ident_2s
   end interface

   interface identity4
      module procedure ident_4
      module procedure ident_4s
   end interface
contains
   function ident_2(T)
      implicit none

      type(Tensor2), intent(in) :: T
      type(Tensor2) :: ident_2
      real(kind=dp) :: ab(3, 3)
      integer :: i
      ! T seems to not be used but refactoring it right now seems painful
      ab = T%ab
      ident_2%ab = 0.d0
      do i = 1, 3
         ident_2%ab(i, i) = 1.d0
      end do

   end function ident_2

   function ident_2s(T)
      implicit none

      type(Tensor2s), intent(in) :: T
      type(Tensor2s) :: ident_2s
      real(kind=dp) :: a6(6)
      integer :: i
      ! T seems to not be used but refactoring it right now seems painful
      a6 = T%a6
      ident_2s%a6 = 0.d0
      do i = 1, 3
         ident_2s%a6(i) = 1.d0
      end do

   end function ident_2s

   function ident_4(T)
      implicit none

      type(Tensor2), intent(in) :: T
      type(Tensor4) :: ident_4

      ident_4 = T.cdya.T

   end function ident_4

   function ident_4s(T)
      implicit none

      type(Tensor2s), intent(in) :: T
      type(Tensor4s) :: ident_4s

      ident_4s = T.cdya.T

   end function ident_4s

end module ttb_identity
