       function sub_11(T1, T2)
        implicit none
        
        type(Tensor1), intent(in) :: T1, T2
        type(Tensor1) :: sub_11

        sub_11%a = T1%a - T2%a
        
       end function sub_11
       
       function sub_22(T1, T2)
        implicit none
        
        type(Tensor2), intent(in) :: T1, T2
        type(Tensor2) :: sub_22

        sub_22%ab = T1%ab - T2%ab
        
       end function sub_22
       
       function sub_2s2s(T1, T2)
        implicit none
        
        type(Tensor2s), intent(in) :: T1, T2
        type(Tensor2s) :: sub_2s2s

        sub_2s2s%a6 = T1%a6 - T2%a6
        
       end function sub_2s2s
       
       function sub_44(T1, T2)
        implicit none
        
        type(Tensor4), intent(in) :: T1, T2
        type(Tensor4) :: sub_44

        sub_44%abcd = T1%abcd - T2%abcd
        
       end function sub_44
       
       function sub_4s4s(T1, T2)
        implicit none
        
        type(Tensor4s), intent(in) :: T1, T2
        type(Tensor4s) :: sub_4s4s

        sub_4s4s%a6b6 = T1%a6b6 - T2%a6b6
        
       end function sub_4s4s