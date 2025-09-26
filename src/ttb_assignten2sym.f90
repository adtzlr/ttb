module ttb_assignten2sym
   use ttb_types
   use ttb_symstore
   use ttb_tensorstore
   interface assignment(=)
      module procedure assignten2sym_2
      module procedure assignten2sym_4
      module procedure assignsym2ten_2
      module procedure assignsym2ten_4
   end interface
contains

   subroutine assignten2sym_2(T, A)
      implicit none

      type(Tensor2s), intent(inout) :: T
      type(Tensor2), intent(in) :: A

      T = voigt(A)

   end subroutine assignten2sym_2

   subroutine assignten2sym_4(T, A)
      implicit none

      type(Tensor4s), intent(inout) :: T
      type(Tensor4), intent(in) :: A

      T = voigt(A)

   end subroutine assignten2sym_4

   subroutine assignsym2ten_2(T, A)
      implicit none

      type(Tensor2), intent(inout) :: T
      type(Tensor2s), intent(in) :: A

      T = astensor(A)

   end subroutine assignsym2ten_2

   subroutine assignsym2ten_4(T, A)
      implicit none

      type(Tensor4), intent(inout) :: T
      type(Tensor4s), intent(in) :: A

      T = astensor(A)

   end subroutine assignsym2ten_4
end module ttb_assignten2sym
