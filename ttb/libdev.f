       function dev_2(T)
        implicit none
        
        type(Tensor2), intent(in) :: T
        type(Tensor2) :: dev_2,Eye
        
        Eye = identity2(Eye)
        dev_2%ab = T%ab - tr(T)/3.d0*Eye%ab
     
       end function dev_2
       
       function dev_2s(T)
        implicit none
        
        type(Tensor2s), intent(in) :: T
        type(Tensor2s) :: dev_2s,Eye
        
        Eye = identity2(Eye)
        dev_2s%a6 = T%a6 - tr(T)/3.d0*Eye%a6
     
       end function dev_2s
