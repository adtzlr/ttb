module ttb_reduce_dim
   use ttb_types
   interface reduce_dim
      module procedure reduce_dim_2s
      module procedure reduce_dim_4s
   end interface
contains
   function reduce_dim_2s(T, i)
      implicit none

      type(Tensor2s), intent(in) :: T
      integer, intent(in) :: i
      real(kind=dp), dimension(i) :: reduce_dim_2s

      reduce_dim_2s = T%a6(1:i)

   end function reduce_dim_2s

   function reduce_dim_4s(T, i, j)
      implicit none

      type(Tensor4s), intent(in) :: T
      integer, intent(in) :: i, j
      real(kind=dp), dimension(i, j) :: reduce_dim_4s

      reduce_dim_4s = T%a6b6(1:i, 1:j)

   end function reduce_dim_4s
end module ttb_reduce_dim
