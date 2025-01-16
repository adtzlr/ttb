module ttb_tensorstore
   use ttb_types
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
contains
   function tenstore_2s(T)
      implicit none

      type(Tensor2s), intent(in) :: T
      type(Tensor2) :: tenstore_2s
      integer :: i

      tenstore_2s%ab = 0.d0
      do i = 1, 3
         tenstore_2s%ab(i, i) = T%a6(i)
      end do
      tenstore_2s%ab(1, 2) = T%a6(4)
      tenstore_2s%ab(2, 3) = T%a6(5)
      tenstore_2s%ab(3, 1) = T%a6(6)
      tenstore_2s%ab(2, 1) = tenstore_2s%ab(1, 2)
      tenstore_2s%ab(3, 2) = tenstore_2s%ab(2, 3)
      tenstore_2s%ab(1, 3) = tenstore_2s%ab(3, 1)

   end function tenstore_2s

   function tenstore_2(T)
      implicit none

      type(Tensor2), intent(in) :: T
      type(Tensor2) :: tenstore_2

      tenstore_2%ab = T%ab

   end function tenstore_2

   function tenstore_2a(T)
      implicit none

      real(kind=dp), dimension(3, 3), intent(in) :: T
      type(Tensor2) :: tenstore_2a

      tenstore_2a%ab = T

   end function tenstore_2a

   function tenstore_4(T)
      implicit none

      type(Tensor4), intent(in) :: T
      type(Tensor4) :: tenstore_4

      tenstore_4%abcd = T%abcd

   end function tenstore_4

   function tenstore_4a(T)
      implicit none

      real(kind=dp), dimension(3, 3, 3, 3), intent(in) :: T
      type(Tensor4) :: tenstore_4a

      tenstore_4a%abcd = T

   end function tenstore_4a

   function tenstore_4s(T)
      implicit none

      type(Tensor4s), intent(in) :: T
      type(Tensor4) :: tenstore_4s
      integer :: i, j, k, l
      integer, dimension(3, 3) :: i6j6

      i6j6 = reshape((/1, 4, 6, 4, 2, 5, 6, 5, 3/), (/3, 3/))
      ! could be replaced with a do concurrent?
      do i = 1, 3
         do j = 1, 3
            do k = 1, 3
               do l = 1, 3
                  tenstore_4s%abcd(i, j, k, l) = T%a6b6(i6j6(i, j), i6j6(k, l))
               end do
            end do
         end do
      end do

!      forall (i=1:3, j=1:3, k=1:3, l=1:3) tenstore_4s%abcd(i, j, k, l) &
!         = T%a6b6(i6j6(i, j), i6j6(k, l))

   end function tenstore_4s
end module ttb_tensorstore
