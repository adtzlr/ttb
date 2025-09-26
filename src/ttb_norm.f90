module ttb_norm
   use ttb_types
   use ttb_ddot
   interface norm
      module procedure norm_1
      module procedure norm_2
      module procedure norm_2s
   end interface
contains
   function norm_1(T)
      implicit none

      type(Tensor1) :: T
      real(kind=dp) :: norm_1

      norm_1 = sqrt(sum((T%a)**2))

   end function norm_1

   function norm_2(T)
      implicit none

      type(Tensor2) :: T
      real(kind=dp) :: norm_2

      norm_2 = sqrt(T**T)

   end function norm_2

   function norm_2s(T)
      implicit none

      type(Tensor2s) :: T
      real(kind=dp) :: norm_2s

      norm_2s = sqrt(T**T)

   end function norm_2s
end module ttb_norm
