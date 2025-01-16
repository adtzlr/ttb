module ttb_inv
   use ttb_types
   use ttb_det
   interface inv
      module procedure inv_2
      module procedure inv_2s
      module procedure inv2d
      module procedure inv2sd
   end interface
contains
   function inv_2(T)
      implicit none

      type(Tensor2), intent(in) :: T
      type(Tensor2) :: inv_2
      real(kind=dp) :: idetT

      idetT = 1.d0/det(T)

      inv_2%ab(1, 1) = +idetT*(T%ab(2, 2)*T%ab(3, 3) - T%ab(2, 3)*T%ab(3, 2))
      inv_2%ab(2, 1) = -idetT*(T%ab(2, 1)*T%ab(3, 3) - T%ab(2, 3)*T%ab(3, 1))
      inv_2%ab(3, 1) = +idetT*(T%ab(2, 1)*T%ab(3, 2) - T%ab(2, 2)*T%ab(3, 1))
      inv_2%ab(1, 2) = -idetT*(T%ab(1, 2)*T%ab(3, 3) - T%ab(1, 3)*T%ab(3, 2))
      inv_2%ab(2, 2) = +idetT*(T%ab(1, 1)*T%ab(3, 3) - T%ab(1, 3)*T%ab(3, 1))
      inv_2%ab(3, 2) = -idetT*(T%ab(1, 1)*T%ab(3, 2) - T%ab(1, 2)*T%ab(3, 1))
      inv_2%ab(1, 3) = +idetT*(T%ab(1, 2)*T%ab(2, 3) - T%ab(1, 3)*T%ab(2, 2))
      inv_2%ab(2, 3) = -idetT*(T%ab(1, 1)*T%ab(2, 3) - T%ab(1, 3)*T%ab(2, 1))
      inv_2%ab(3, 3) = +idetT*(T%ab(1, 1)*T%ab(2, 2) - T%ab(1, 2)*T%ab(2, 1))

   end function inv_2

   function inv_2s(T)
      implicit none

      type(Tensor2s), intent(in) :: T
      type(Tensor2s) :: inv_2s
      real(kind=dp) :: idetT

      idetT = 1.d0/det(T)

      inv_2s%a6(1) = +idetT*(T%a6(2)*T%a6(3) - T%a6(5)*T%a6(5))
      inv_2s%a6(4) = -idetT*(T%a6(4)*T%a6(3) - T%a6(5)*T%a6(6))
      inv_2s%a6(6) = +idetT*(T%a6(4)*T%a6(5) - T%a6(2)*T%a6(6))
      inv_2s%a6(2) = +idetT*(T%a6(1)*T%a6(3) - T%a6(6)*T%a6(6))
      inv_2s%a6(5) = -idetT*(T%a6(1)*T%a6(5) - T%a6(4)*T%a6(6))
      inv_2s%a6(3) = +idetT*(T%a6(1)*T%a6(2) - T%a6(4)*T%a6(4))

   end function inv_2s

   function inv2d(T, detT)
      implicit none

      type(Tensor2), intent(in) :: T
      type(Tensor2) :: inv2d
      real(kind=dp) :: detT, idetT

      idetT = 1.d0/detT

      inv2d%ab(1, 1) = +idetT*(T%ab(2, 2)*T%ab(3, 3) - T%ab(2, 3)*T%ab(3, 2))
      inv2d%ab(2, 1) = -idetT*(T%ab(2, 1)*T%ab(3, 3) - T%ab(2, 3)*T%ab(3, 1))
      inv2d%ab(3, 1) = +idetT*(T%ab(2, 1)*T%ab(3, 2) - T%ab(2, 2)*T%ab(3, 1))
      inv2d%ab(1, 2) = -idetT*(T%ab(1, 2)*T%ab(3, 3) - T%ab(1, 3)*T%ab(3, 2))
      inv2d%ab(2, 2) = +idetT*(T%ab(1, 1)*T%ab(3, 3) - T%ab(1, 3)*T%ab(3, 1))
      inv2d%ab(3, 2) = -idetT*(T%ab(1, 1)*T%ab(3, 2) - T%ab(1, 2)*T%ab(3, 1))
      inv2d%ab(1, 3) = +idetT*(T%ab(1, 2)*T%ab(2, 3) - T%ab(1, 3)*T%ab(2, 2))
      inv2d%ab(2, 3) = -idetT*(T%ab(1, 1)*T%ab(2, 3) - T%ab(1, 3)*T%ab(2, 1))
      inv2d%ab(3, 3) = +idetT*(T%ab(1, 1)*T%ab(2, 2) - T%ab(1, 2)*T%ab(2, 1))

   end function inv2d

   function inv2sd(T, detT)
      implicit none

      type(Tensor2s), intent(in) :: T
      type(Tensor2s) :: inv2sd
      real(kind=dp):: detT, idetT

      idetT = 1.d0/detT

      inv2sd%a6(1) = +idetT*(T%a6(2)*T%a6(3) - T%a6(5)*T%a6(5))
      inv2sd%a6(4) = -idetT*(T%a6(4)*T%a6(3) - T%a6(5)*T%a6(6))
      inv2sd%a6(6) = +idetT*(T%a6(4)*T%a6(5) - T%a6(2)*T%a6(6))
      inv2sd%a6(2) = +idetT*(T%a6(1)*T%a6(3) - T%a6(6)*T%a6(6))
      inv2sd%a6(5) = -idetT*(T%a6(1)*T%a6(5) - T%a6(4)*T%a6(6))
      inv2sd%a6(3) = +idetT*(T%a6(1)*T%a6(2) - T%a6(4)*T%a6(4))

   end function inv2sd

end module ttb_inv
