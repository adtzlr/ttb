module ttb_cdya
   use ttb_types
   interface operator(.cdya.)
      ! symmetric crossed dyadic product of rank 2 tensor combinations
      ! (i,j,k,l) = 1/2 * (i,k,j,l)*(i,l,j,k)
      module procedure crossdyadic_22
      module procedure crossdyadic_2s2s
   end interface

contains
   function crossdyadic_22(T1, T2)
      implicit none

      type(Tensor2), intent(in) :: T1, T2
      type(Tensor4) :: crossdyadic_22
      integer i, j, k, l

      ! forall (i=1:3, j=1:3, k=1:3, l=1:3) crossdyadic_22%abcd(i, j, k, l) &
      !    = (T1%ab(i, k)*T2%ab(j, l) + T1%ab(i, l)*T2%ab(j, k) + &
      !       T2%ab(i, k)*T1%ab(j, l) + T2%ab(i, l)*T1%ab(j, k))/4.d0

      do i = 1, 3
         do j = 1, 3
            do k = 1, 3
               do l = 1, 3
                  crossdyadic_22%abcd(i, j, k, l) = &
                     (T1%ab(i, k)*T2%ab(j, l) + T1%ab(i, l)*T2%ab(j, k) + &
                      T2%ab(i, k)*T1%ab(j, l) + T2%ab(i, l)*T1%ab(j, k))/4.d0
               end do
            end do
         end do
      end do

   end function crossdyadic_22

   function crossdyadic_2s2s(T1, T2)
      implicit none

      type(Tensor2s), intent(in) :: T1, T2
      type(Tensor4s) :: crossdyadic_2s2s
      integer :: i, j, k, l
      integer, dimension(3, 3) :: i6

      i6 = reshape((/1, 4, 6, 4, 2, 5, 6, 5, 3/), (/3, 3/))

      crossdyadic_2s2s%a6b6 = 0.d0

      do i = 1, 3
         do j = 1, 3
         if (i .le. j) then
            do k = 1, 3
               do l = 1, 3
               if (k .le. l) then
                  crossdyadic_2s2s%a6b6(i6(i, j), i6(k, l)) &
                     = (T1%a6(i6(i, k))*T2%a6(i6(j, l)) &
                        + T1%a6(i6(i, l))*T2%a6(i6(j, k)) &
                        + T2%a6(i6(i, k))*T1%a6(i6(j, l)) &
                        + T2%a6(i6(i, l))*T1%a6(i6(j, k)))/4.d0
               end if
               end do
            end do
         end if
         end do
      end do

   end function crossdyadic_2s2s
end module ttb_cdya
