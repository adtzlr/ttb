
module ttb_assignscalar

   use ttb_types
   interface assignment(=)
      module procedure assignscalar_1
      module procedure assignscalar_2
      module procedure assignscalar_2s
      module procedure assignscalar_4
      module procedure assignscalar_4s
      module procedure assignscalar_1r4
      module procedure assignscalar_2r4
      module procedure assignscalar_2sr4
      module procedure assignscalar_4r4
      module procedure assignscalar_4sr4
   end interface

contains
   subroutine assignscalar_2s(T, w)
      implicit none

      type(Tensor2s), intent(inout) :: T
      real(kind=dp), intent(in) :: w

      T%a6 = w

   end subroutine assignscalar_2s

   subroutine assignscalar_2sr4(T, w)
      implicit none

      type(Tensor2s), intent(inout) :: T
      real(kind=4), intent(in) :: w

      T%a6 = dble(w)

   end subroutine assignscalar_2sr4

   subroutine assignscalar_4s(T, w)
      implicit none

      type(Tensor4s), intent(inout) :: T
      real(kind=dp), intent(in) :: w

      T%a6b6 = w

   end subroutine assignscalar_4s

   subroutine assignscalar_4sr4(T, w)
      implicit none

      type(Tensor4s), intent(inout) :: T
      real(kind=4), intent(in) :: w

      T%a6b6 = dble(w)

   end subroutine assignscalar_4sr4

   subroutine assignscalar_1(T, w)
      implicit none

      type(Tensor1), intent(inout) :: T
      real(kind=dp), intent(in) :: w

      T%a = w

   end subroutine assignscalar_1

   subroutine assignscalar_1r4(T, w)
      implicit none

      type(Tensor1), intent(inout) :: T
      real(kind=4), intent(in) :: w

      T%a = dble(w)

   end subroutine assignscalar_1r4

   subroutine assignscalar_2(T, w)
      implicit none

      type(Tensor2), intent(inout) :: T
      real(kind=dp), intent(in) :: w

      T%ab = w

   end subroutine assignscalar_2

   subroutine assignscalar_2r4(T, w)
      implicit none

      type(Tensor2), intent(inout) :: T
      real(kind=4), intent(in) :: w

      T%ab = dble(w)

   end subroutine assignscalar_2r4

   subroutine assignscalar_4(T, w)
      implicit none

      type(Tensor4), intent(inout) :: T
      real(kind=dp), intent(in) :: w

      T%abcd = w

   end subroutine assignscalar_4

   subroutine assignscalar_4r4(T, w)
      implicit none

      type(Tensor4), intent(inout) :: T
      real(kind=4), intent(in) :: w

      T%abcd = dble(w)

   end subroutine assignscalar_4r4

end module ttb_assignscalar
