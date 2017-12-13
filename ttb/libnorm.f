       function norm_1(T)
        implicit none
        
        type(Tensor1) :: T
        real(kind=8) :: norm_1
        
        norm_1 = sqrt(sum((T%a)**2))
        
       end function norm_1