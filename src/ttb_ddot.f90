module ttb_ddot
   use ttb_types
   !use ttb_pow
   interface operator(**)
      ! double dot-product of rank 1 and rank 2 tensor combinations
      module procedure ddot_22
      module procedure ddot_2s2s
      module procedure ddot_24
      module procedure ddot_2s4s
      module procedure ddot_42
      module procedure ddot_4s2s
      module procedure ddot_44
      module procedure ddot_4s4s
   end interface

   interface operator(.ddot.)
      ! double dot-product of rank 1 and rank 2 tensor combinations
      module procedure ddot_22
      module procedure ddot_2s2s
      module procedure ddot_24
      module procedure ddot_2s4s
      module procedure ddot_42
      module procedure ddot_4s2s
      module procedure ddot_44
      module procedure ddot_4s4s
   end interface
contains
   function ddot_22(T1, T2)
      implicit none

      type(Tensor2), intent(in) :: T1
      type(Tensor2), intent(in) :: T2
      real(kind=dp) :: ddot_22
      integer :: i, j

      ddot_22 = 0.d0
      do i = 1, 3
         do j = 1, 3
            ddot_22 = ddot_22 + T1%ab(i, j)*T2%ab(i, j)
         end do
      end do

   end function ddot_22

   function ddot_2s2s(T1, T2)
      implicit none

      type(Tensor2s), intent(in) :: T1
      type(Tensor2s), intent(in) :: T2
      real(kind=dp) :: ddot_2s2s
      integer :: i

      ddot_2s2s = 0.d0
      do i = 1, 3
         ddot_2s2s = ddot_2s2s + T1%a6(i)*T2%a6(i)
      end do
      do i = 4, 6
         ddot_2s2s = ddot_2s2s + T1%a6(i)*T2%a6(i)*2.d0
      end do

   end function ddot_2s2s

   function ddot_24(T1, T2)
      implicit none

      type(Tensor2), intent(in) :: T1
      type(Tensor4), intent(in) :: T2
      type(Tensor2) :: ddot_24
      integer :: i, j, k, l

      ddot_24%ab = 0.d0
      do i = 1, 3
         do j = 1, 3
            do k = 1, 3
               do l = 1, 3
                  ddot_24%ab(k, l) = ddot_24%ab(k, l) &
                                     + T1%ab(i, j)*T2%abcd(i, j, k, l)
               end do
            end do
         end do
      end do

   end function ddot_24

   function ddot_2s4s(T1, T2)
      implicit none

      type(Tensor2s), intent(in) :: T1
      type(Tensor4s), intent(in) :: T2
      type(Tensor2s) :: ddot_2s4s
      real(kind=dp) :: w
      integer :: i, j

      ddot_2s4s%a6 = 0.d0
      do i = 1, 6
         do j = 1, 6
            if (i > 3) then
               w = 2.d0
            else
               w = 1.d0
            end if
            ddot_2s4s%a6(j) = ddot_2s4s%a6(j) &
                              + T1%a6(i)*T2%a6b6(i, j)*w
         end do
      end do

   end function ddot_2s4s

   function ddot_42(T1, T2)
      implicit none

      type(Tensor4), intent(in) :: T1
      type(Tensor2), intent(in) :: T2
      type(Tensor2) :: ddot_42
      integer :: i, j, k, l

      ddot_42%ab = 0.d0
      do i = 1, 3
         do j = 1, 3
            do k = 1, 3
               do l = 1, 3
                  ddot_42%ab(i, j) = ddot_42%ab(i, j) &
                                     + T1%abcd(i, j, k, l)*T2%ab(k, l)
               end do
            end do
         end do
      end do

   end function ddot_42

   function ddot_4s2s(T1, T2)
      implicit none

      type(Tensor4s), intent(in) :: T1
      type(Tensor2s), intent(in) :: T2
      type(Tensor2s) :: ddot_4s2s
      real(kind=dp) :: w
      integer :: i, j

      ddot_4s2s%a6 = 0.d0
      do i = 1, 6
         do j = 1, 6
            if (j > 3) then
               w = 2.d0
            else
               w = 1.d0
            end if
            ddot_4s2s%a6(i) = ddot_4s2s%a6(i) &
                              + T1%a6b6(i, j)*T2%a6(j)*w
         end do
      end do

   end function ddot_4s2s

   function ddot_44(T1, T2)
      implicit none

      type(Tensor4), intent(in) :: T1
      type(Tensor4), intent(in) :: T2
      type(Tensor4) :: ddot_44
      integer :: i, j, k, l, m, n

      ddot_44%abcd = 0.d0
      do i = 1, 3
         do j = 1, 3
            do m = 1, 3
               do n = 1, 3
                  do k = 1, 3
                     do l = 1, 3
                        ddot_44%abcd(i, j, k, l) = ddot_44%abcd(i, j, k, l) &
                                                   + T1%abcd(i, j, m, n)*T2%abcd(m, n, k, l)
                     end do
                  end do
               end do
            end do
         end do
      end do
   end function ddot_44

   function ddot_4s4s(T1, T2)
      implicit none

      type(Tensor4s), intent(in) :: T1
      type(Tensor4s), intent(in) :: T2
      type(Tensor4s) :: ddot_4s4s
      real(kind=dp) :: w
      integer :: i, j, k

      ddot_4s4s%a6b6 = 0.d0
      do i = 1, 6
         do k = 1, 6
            do j = 1, 6
               if (k > 3) then
                  w = 2.d0
               else
                  w = 1.d0
               end if
               ddot_4s4s%a6b6(i, j) = ddot_4s4s%a6b6(i, j) &
                                      + T1%a6b6(i, k)*T2%a6b6(k, j)*w
            end do
         end do
      end do

   end function ddot_4s4s
end module ttb_ddot
