module ttb_asarray
   use ttb_types
   interface asarray
      module procedure asarray_1
      module procedure asarray_2
      module procedure asarray_4
      module procedure asarray_2s
      module procedure asarray_4s
   end interface
contains
!      ------AS ARRAY SECTION------------------------------------
   function asarray_1(T, i)
      !function asarray_1(T, i, j, k, l)
      implicit none

      type(Tensor1), intent(in) :: T
      integer, intent(in) :: i
      !integer, intent(in), optional :: j, k, l
      real(kind=dp), dimension(i) :: asarray_1

      asarray_1 = T%a(1:i)

   end function asarray_1

   function asarray_2(T, i, j)
      !function asarray_2(T, i, j, k, l)
      implicit none

      type(Tensor2), intent(in) :: T
      integer, intent(in) :: i, j
      !integer, intent(in), optional :: k, l
      real(kind=dp), dimension(i, j) :: asarray_2

      asarray_2 = T%ab(1:i, 1:j)

   end function asarray_2

   function asarray_2s(T, i)
      !function asarray_2s(T, i, j, k, l)
      implicit none

      type(Tensor2s), intent(in) :: T
      integer, intent(in) :: i
!      integer, intent(in), optional :: j, k, l
      real(kind=dp), dimension(i) :: asarray_2s

      asarray_2s = T%a6(1:i)

   end function asarray_2s

   function asarray_4(T, i, j, k, l)
      implicit none

      type(Tensor4), intent(in) :: T
      integer, intent(in) :: i, j, k, l
      real(kind=dp), dimension(i, j, k, l) :: asarray_4

      asarray_4 = T%abcd(1:i, 1:j, 1:k, 1:l)

   end function asarray_4

   function asarray_4s(T, i, j)
      !function asarray_4s(T, i, j, k, l)
      implicit none

      type(Tensor4s), intent(in) :: T
      integer, intent(in) :: i, j
      !   integer, intent(in), optional :: k, l
      real(kind=dp), dimension(i, j) :: asarray_4s

      asarray_4s = T%a6b6(1:i, 1:j)

   end function asarray_4s
end module ttb_asarray
