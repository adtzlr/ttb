       function det_2(T)
        implicit none
        
        type(Tensor2) :: T
        real(kind=8) :: det_2
        
        det_2 = T%ab(1,1)*(T%ab(2,2)*T%ab(3,3)-T%ab(2,3)*T%ab(3,2))
     *        + T%ab(1,2)*(T%ab(2,3)*T%ab(3,1)-T%ab(2,1)*T%ab(3,3))
     *        + T%ab(1,3)*(T%ab(2,1)*T%ab(3,2)-T%ab(2,2)*T%ab(3,1))
     
       end function det_2
       
       function det_2s(T)
        implicit none
        
        type(Tensor2s), intent(in) :: T
        real(kind=8) :: det_2s
        
        det_2s = T%a6(1)*T%a6(2)*T%a6(3)
     *         + T%a6(4)*T%a6(5)*T%a6(6)
     *         + T%a6(6)*T%a6(4)*T%a6(5)
     *         - T%a6(6)*T%a6(2)*T%a6(6)
     *         - T%a6(5)*T%a6(5)*T%a6(1)
     *         - T%a6(3)*T%a6(4)*T%a6(4)
       
       end function det_2s
       