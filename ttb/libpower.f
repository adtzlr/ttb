       function pow_2(T,i)
        implicit none
        
        type(Tensor2), intent(in) :: T
        integer, intent(in) :: i
        
        type(Tensor2) :: pow_2, invT
        integer :: j
        
        if (i > 0) then
         pow_2 = T
         do j=1,i-1
          pow_2 = pow_2*T
         end do
        else if (i == 0) then
         pow_2 = identity2(T)
        else
         invT = inv(T)
         pow_2 = invT
         do j=1,abs(i)-1
          pow_2 = pow_2*invT
         end do
        end if
     
       end function pow_2
       
       function pow_2s(T,i)
        implicit none
        
        type(Tensor2s), intent(in) :: T
        integer, intent(in) :: i
        
        type(Tensor2s) :: pow_2s, invT
        integer :: j
        
        if (i > 0) then
         pow_2s = T
         do j=1,i-1
          pow_2s = pow_2s*T
         end do
        else if (i == 0) then
         pow_2s = identity2(T)
        else
         invT = inv(T)
         pow_2s = invT
         do j=1,abs(i)-1
          pow_2s = pow_2s*invT
         end do
        end if
     
       end function pow_2s
       
