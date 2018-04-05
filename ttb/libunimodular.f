       function unimod_2(T)
        implicit none
        
        type(Tensor2), intent(in) :: T
        type(Tensor2) :: unimod_2, Eye
        real(kind=8) :: detT
        
        detT = det(T)
        Eye = identity2(Eye)
        
        unimod_2 = detT**(-1./3.) * T
        
       end function unimod_2
       
       function unimod_2s(T)
        implicit none
        
        type(Tensor2s), intent(in) :: T
        type(Tensor2s) :: unimod_2s, Eye
        real(kind=8) :: detT
        
        detT = det(T)
        Eye = identity2(Eye)
        
        unimod_2s = detT**(-1./3.) * T
        
       end function unimod_2s
       
       function unimod_2d(T,detT)
        implicit none
        
        type(Tensor2), intent(in) :: T
        type(Tensor2) :: unimod_2d, Eye
        real(kind=8), intent(in) :: detT

        Eye = identity2(Eye)
        
        unimod_2d = detT**(-1./3.) * T
        
       end function unimod_2d
       
       function unimod_2sd(T,detT)
        implicit none
        
        type(Tensor2s), intent(in) :: T
        type(Tensor2s) :: unimod_2sd, Eye
        real(kind=8), intent(in) :: detT

        Eye = identity2(Eye)
        
        unimod_2sd = detT**(-1./3.) * T
        
       end function unimod_2sd