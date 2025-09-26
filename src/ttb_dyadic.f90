module ttb_dya
   use ttb_types
   interface operator(.dya.)
      ! dyadic product of rank 2 and rank 4 tensor combinations
      module procedure dyadic_11
      module procedure dyadic_22
      module procedure dyadic_2s2s
   end interface
contains
   function dyadic_11(T1, T2)
      implicit none

      type(Tensor1), intent(in) :: T1, T2
      type(Tensor2) :: dyadic_11
      integer i, j

      !forall (i=1:3, j=1:3) dyadic_11%ab(i, j) = T1%a(i)*T2%a(j)
      do i = 1, 3
         do j = 1, 3
            dyadic_11%ab(i, j) = T1%a(i)*T2%a(j)
         end do
      end do

   end function dyadic_11

   function dyadic_22(T1, T2)
      implicit none

      type(Tensor2), intent(in) :: T1, T2
      type(Tensor4) :: dyadic_22
      integer i, j, k, l

      ! forall (i=1:3, j=1:3, k=1:3, l=1:3) dyadic_22%abcd(i, j, k, l) &
      !    = T1%ab(i, j)*T2%ab(k, l)
      do i = 1, 3
         do j = 1, 3
            do k = 1, 3
               do l = 1, 3
                  dyadic_22%abcd(i, j, k, l) = T1%ab(i, j)*T2%ab(k, l)
               end do
            end do
         end do
      end do

   end function dyadic_22

   function dyadic_2s2s(T1, T2)
      implicit none

      type(Tensor2s), intent(in) :: T1, T2
      type(Tensor4s) :: dyadic_2s2s
      integer i, j

      !forall (i=1:6, j=1:6) dyadic_2s2s%a6b6(i, j) = T1%a6(i)*T2%a6(j)
      do i = 1, 6
         do j = 1, 6
            dyadic_2s2s%a6b6(i, j) = T1%a6(i)*T2%a6(j)
         end do
      end do

   end function dyadic_2s2s
end module ttb_dya
