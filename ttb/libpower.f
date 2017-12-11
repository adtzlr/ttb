       function pow_2(T,i)
        implicit none
        
        type(Tensor2), intent(in) :: T
        integer, intent(in) :: i
        
        type(Tensor2) :: pow_2
        integer :: j
        
        pow_2 = T
        do j=1,i-1
         pow_2 = pow_2*T
        end do
     
       end function pow_2
       
       function pow_2s(T,i)
        implicit none
        
        type(Tensor2s), intent(in) :: T
        integer, intent(in) :: i
        
        type(Tensor2s) :: pow_2s
        integer :: j
        
        pow_2s = T
        do j=1,i-1
         pow_2s = pow_2s*T
        end do
     
       end function pow_2s
       