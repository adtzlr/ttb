       function ln_2(T)
        implicit none
        
        type(Tensor2), intent(in) :: T
        type(Tensor2) :: ln_2, Eye
        real(kind=8), dimension(20) :: g,a
        integer :: i
        
        Eye = identity2(Eye)
        g = (/ 1./1., -1./2., 1./3., -1./4., 1./5.,
     *         -1./6.,  1./7.,  -1./8.,  1./9.,
     *         -1./10., 1./11., -1./12., 1./13.,
     *         -1./14., 1./15., -1./16., 1./17.,
     *         -1./18., 1./19., -1./20. /)
        a = 1.0d0
        
        ln_2 = g(1)*(T-a(1)*Eye)
        do i=2,20
         ln_2 = ln_2 + g(i) * ((T-a(i)*Eye)**i)
        end do
     
       end function ln_2
       
       function ln_2s(T)
        implicit none
        
        type(Tensor2s), intent(in) :: T
        type(Tensor2s) :: ln_2s, Eye
        real(kind=8), dimension(20) :: g,a
        integer :: i
        
        Eye = identity2(Eye)
        g = (/ 1./1., -1./2., 1./3., -1./4., 1./5.,
     *         -1./6.,  1./7.,  -1./8.,  1./9.,
     *         -1./10., 1./11., -1./12., 1./13.,
     *         -1./14., 1./15., -1./16., 1./17.,
     *         -1./18., 1./19., -1./20. /)
        a = 1.0d0
        
        ln_2s = g(1)*(T-a(1)*Eye)
        do i=2,20
         ln_2s = ln_2s + g(i) * ((T-a(i)*Eye)**i)
        end do
     
       end function ln_2s
       