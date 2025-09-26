module ttb_trace
   use ttb_types
   interface tr
      module procedure tr_2
      module procedure tr_2s
   end interface
contains
   function tr_2(T)
      implicit none

      type(Tensor2) :: T
      real(kind=dp) :: tr_2

      tr_2 = T%ab(1, 1) + T%ab(2, 2) + T%ab(3, 3)

   end function tr_2

   function tr_2s(T)
      implicit none

      type(Tensor2s) :: T
      real(kind=dp) :: tr_2s

      tr_2s = T%a6(1) + T%a6(2) + T%a6(3)

   end function tr_2s
end module ttb_trace
