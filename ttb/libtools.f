       function fact_i(n)
       
        integer, intent(in) :: n
        real(kind=8) :: fact_i
        integer :: i

        fact_i = 1.d0
        do i = 2, n
            fact_i = fact_i * i
        enddo
        
       end function fact_i