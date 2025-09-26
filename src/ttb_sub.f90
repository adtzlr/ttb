module ttb_sub
   use ttb_types
   use ttb_tensorstore
   interface operator(-)
      ! subtraction of rank 1 and rank 2 tensors
      module procedure sub_11
      module procedure sub_22
      module procedure sub_44
      module procedure sub_2s2s
      module procedure sub_22s
      module procedure sub_2s2
      module procedure sub_4s4s
      module procedure sub_44s
      module procedure sub_4s4
   end interface
   interface operator(.sub.)
      ! subtraction of rank 1 and rank 2 tensors
      module procedure sub_11
      module procedure sub_22
      module procedure sub_44
      module procedure sub_2s2s
      module procedure sub_22s
      module procedure sub_2s2
      module procedure sub_4s4s
      module procedure sub_44s
      module procedure sub_4s4
   end interface

contains

   function sub_11(T1, T2)
      implicit none

      type(Tensor1), intent(in) :: T1, T2
      type(Tensor1) :: sub_11

      sub_11%a = T1%a - T2%a

   end function sub_11

   function sub_22(T1, T2)
      implicit none

      type(Tensor2), intent(in) :: T1, T2
      type(Tensor2) :: sub_22

      sub_22%ab = T1%ab - T2%ab

   end function sub_22

   function sub_2s2s(T1, T2)
      implicit none

      type(Tensor2s), intent(in) :: T1, T2
      type(Tensor2s) :: sub_2s2s

      sub_2s2s%a6 = T1%a6 - T2%a6

   end function sub_2s2s

   function sub_22s(T1, T2)
      implicit none

      type(Tensor2), intent(in) :: T1
      type(Tensor2s), intent(in) :: T2
      type(Tensor2) :: sub_22s

      sub_22s = T1 - astensor(T2)

   end function sub_22s

   function sub_2s2(T1, T2)
      implicit none

      type(Tensor2s), intent(in) :: T1
      type(Tensor2), intent(in) :: T2
      type(Tensor2) :: sub_2s2

      sub_2s2 = astensor(T1) - T2

   end function sub_2s2

   function sub_44(T1, T2)
      implicit none

      type(Tensor4), intent(in) :: T1, T2
      type(Tensor4) :: sub_44

      sub_44%abcd = T1%abcd - T2%abcd

   end function sub_44

   function sub_4s4s(T1, T2)
      implicit none

      type(Tensor4s), intent(in) :: T1, T2
      type(Tensor4s) :: sub_4s4s

      sub_4s4s%a6b6 = T1%a6b6 - T2%a6b6

   end function sub_4s4s

   function sub_44s(T1, T2)
      implicit none

      type(Tensor4), intent(in) :: T1
      type(Tensor4s), intent(in) :: T2
      type(Tensor4) :: sub_44s

      sub_44s = T1 - astensor(T2)

   end function sub_44s

   function sub_4s4(T1, T2)
      implicit none

      type(Tensor4s), intent(in) :: T1
      type(Tensor4), intent(in) :: T2
      type(Tensor4) :: sub_4s4

      sub_4s4 = astensor(T1) - T2

   end function sub_4s4
end module ttb_sub
