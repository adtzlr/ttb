program test
   use Tensor
   implicit none
   type(Tensor1) :: a, b, c

   a%a = 2.0_dp
   b%a = 1.0_dp
   c%a = 0.0_dp

   c = a + b
   print *, c

   call print_banner()
end program test
