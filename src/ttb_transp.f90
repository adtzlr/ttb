module ttb_transpose
   use ttb_types
   interface transpose
      module procedure transp2
      module procedure transp2s
      module procedure transp4
      module procedure transp4s
   end interface

contains
   function transp2(T)
      implicit none

      type(Tensor2), intent(in) :: T
      type(Tensor2) :: transp2

      transp2%ab = transpose(T%ab)

   end function transp2

   function transp2s(T)
      implicit none

      type(Tensor2s), intent(in) :: T
      type(Tensor2s) :: transp2s

      transp2s%a6 = T%a6

   end function transp2s

   function transp4(T)
      implicit none

      type(Tensor4), intent(in) :: T
      type(Tensor4) :: transp4
      integer :: i, j, k, l

      transp4%abcd = 0.d0
      ! forall (i=1:3, j=1:3, k=1:3, l=1:3) transp4%abcd(i, j, k, l) &
      !    = T%abcd(k, l, i, j)

      do i = 1, 3
         do j = 1, 3
            do k = 1, 3
               do l = 1, 3
                  transp4%abcd(i, j, k, l) = T%abcd(k, l, i, j)
               end do
            end do
         end do
      end do

   end function transp4

   function transp4s(T)
      implicit none

      type(Tensor4s), intent(in) :: T
      type(Tensor4s) :: transp4s

      transp4s%a6b6 = transpose(T%a6b6)

   end function transp4s

end module ttb_transpose
