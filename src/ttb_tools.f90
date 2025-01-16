module ttb_fact
   use ttb_types
   interface fact
      module procedure fact_i
   end interface
contains
   function fact_i(n)

      integer, intent(in) :: n
      real(kind=dp) :: fact_i
      integer :: i

      fact_i = 1.d0
      do i = 2, n
         fact_i = fact_i*i
      end do

   end function fact_i
end module ttb_fact
