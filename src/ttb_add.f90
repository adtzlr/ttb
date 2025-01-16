module ttb_add
   use ttb_types
   use ttb_tensorstore
   interface operator(+)
      ! addition of rank 1 and rank 2 tensors
      module procedure add_11
      module procedure add_22
      module procedure add_44
      module procedure add_2s2s
      module procedure add_22s
      module procedure add_2s2
      module procedure add_4s4s
      module procedure add_44s
      module procedure add_4s4
   end interface
   interface operator(.add.)
      ! addition of rank 1 and rank 2 tensors
      module procedure add_11
      module procedure add_22
      module procedure add_44
      module procedure add_2s2s
      module procedure add_22s
      module procedure add_2s2
      module procedure add_4s4s
      module procedure add_44s
      module procedure add_4s4
   end interface
contains
   function add_11(T1, T2)
      implicit none

      type(Tensor1), intent(in) :: T1, T2
      type(Tensor1) :: add_11

      add_11%a = T1%a + T2%a

   end function add_11

   function add_22(T1, T2)
      implicit none

      type(Tensor2), intent(in) :: T1, T2
      type(Tensor2) :: add_22

      add_22%ab = T1%ab + T2%ab

   end function add_22

   function add_2s2s(T1, T2)
      implicit none

      type(Tensor2s), intent(in) :: T1, T2
      type(Tensor2s) :: add_2s2s

      add_2s2s%a6 = T1%a6 + T2%a6

   end function add_2s2s

   function add_22s(T1, T2)
      implicit none

      type(Tensor2), intent(in) :: T1
      type(Tensor2s), intent(in) :: T2
      type(Tensor2) :: add_22s

      add_22s = T1 + astensor(T2)

   end function add_22s

   function add_2s2(T1, T2)
      implicit none

      type(Tensor2s), intent(in) :: T1
      type(Tensor2), intent(in) :: T2
      type(Tensor2) :: add_2s2

      add_2s2 = astensor(T1) + T2

   end function add_2s2

   function add_44(T1, T2)
      implicit none

      type(Tensor4), intent(in) :: T1, T2
      type(Tensor4) :: add_44

      add_44%abcd = T1%abcd + T2%abcd

   end function add_44

   function add_4s4s(T1, T2)
      implicit none

      type(Tensor4s), intent(in) :: T1, T2
      type(Tensor4s) :: add_4s4s

      add_4s4s%a6b6 = T1%a6b6 + T2%a6b6

   end function add_4s4s

   function add_44s(T1, T2)
      implicit none

      type(Tensor4), intent(in) :: T1
      type(Tensor4s), intent(in) :: T2
      type(Tensor4) :: add_44s

      add_44s = T1 + astensor(T2)

   end function add_44s

   function add_4s4(T1, T2)
      implicit none

      type(Tensor4s), intent(in) :: T1
      type(Tensor4), intent(in) :: T2
      type(Tensor4) :: add_4s4

      add_4s4 = astensor(T1) + T2

   end function add_4s4

end module ttb_add
