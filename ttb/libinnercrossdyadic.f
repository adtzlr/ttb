       function icrossdyadic_22(T1, T2)
       ! (i,j,k,l) --> (i,k,j,l)
        implicit none
        
        type(Tensor2), intent(in) :: T1, T2
        type(Tensor4) :: icrossdyadic_22
        integer i, j, k, l
        
        forall(i=1:3,j=1:3,k=1:3,l=1:3) icrossdyadic_22%abcd(i,j,k,l)
     *                                = T1%ab(i,k) * T2%ab(j,l)
        
       end function icrossdyadic_22
       
       function icrossdyadic_2s2s(T1, T2)
       ! (i,j,k,l) --> (i,k,j,l)
        implicit none
        
        type(Tensor2s), intent(in) :: T1, T2
        type(Tensor4s) :: icrossdyadic_2s2s
        
        icrossdyadic_2s2s%a6b6(1,1) = T1%a6(1) * T2%a6(1)
        icrossdyadic_2s2s%a6b6(2,1) = T1%a6(4) * T2%a6(4)
        icrossdyadic_2s2s%a6b6(3,1) = T1%a6(6) * T2%a6(6)
        icrossdyadic_2s2s%a6b6(4,1) = T1%a6(1) * T2%a6(4)
        icrossdyadic_2s2s%a6b6(5,1) = T1%a6(4) * T2%a6(6)
        icrossdyadic_2s2s%a6b6(6,1) = T1%a6(6) * T2%a6(1)
        
        icrossdyadic_2s2s%a6b6(1,2) = T1%a6(4) * T2%a6(4)
        icrossdyadic_2s2s%a6b6(2,2) = T1%a6(2) * T2%a6(2)
        icrossdyadic_2s2s%a6b6(3,2) = T1%a6(5) * T2%a6(5)
        icrossdyadic_2s2s%a6b6(4,2) = T1%a6(4) * T2%a6(2)
        icrossdyadic_2s2s%a6b6(5,2) = T1%a6(2) * T2%a6(5)
        icrossdyadic_2s2s%a6b6(6,2) = T1%a6(5) * T2%a6(4)
        
        icrossdyadic_2s2s%a6b6(1,3) = T1%a6(6) * T2%a6(6)
        icrossdyadic_2s2s%a6b6(2,3) = T1%a6(5) * T2%a6(5)
        icrossdyadic_2s2s%a6b6(3,3) = T1%a6(3) * T2%a6(3)
        icrossdyadic_2s2s%a6b6(4,3) = T1%a6(6) * T2%a6(5)
        icrossdyadic_2s2s%a6b6(5,3) = T1%a6(5) * T2%a6(3)
        icrossdyadic_2s2s%a6b6(6,3) = T1%a6(3) * T2%a6(6)
        
        icrossdyadic_2s2s%a6b6(1,4) = T1%a6(1) * T2%a6(4)
        icrossdyadic_2s2s%a6b6(2,4) = T1%a6(4) * T2%a6(2)
        icrossdyadic_2s2s%a6b6(3,4) = T1%a6(6) * T2%a6(5)
        icrossdyadic_2s2s%a6b6(4,4) = T1%a6(1) * T2%a6(2)
        icrossdyadic_2s2s%a6b6(5,4) = T1%a6(4) * T2%a6(5)
        icrossdyadic_2s2s%a6b6(6,4) = T1%a6(6) * T2%a6(4)
     
        icrossdyadic_2s2s%a6b6(1,5) = T1%a6(4) * T2%a6(6)
        icrossdyadic_2s2s%a6b6(2,5) = T1%a6(2) * T2%a6(5)
        icrossdyadic_2s2s%a6b6(3,5) = T1%a6(5) * T2%a6(3)
        icrossdyadic_2s2s%a6b6(4,5) = T1%a6(4) * T2%a6(5)
        icrossdyadic_2s2s%a6b6(5,5) = T1%a6(2) * T2%a6(3)
        icrossdyadic_2s2s%a6b6(6,5) = T1%a6(5) * T2%a6(6)
     
        icrossdyadic_2s2s%a6b6(1,6) = T1%a6(6) * T2%a6(1)
        icrossdyadic_2s2s%a6b6(2,6) = T1%a6(5) * T2%a6(4)
        icrossdyadic_2s2s%a6b6(3,6) = T1%a6(3) * T2%a6(6)
        icrossdyadic_2s2s%a6b6(4,6) = T1%a6(6) * T2%a6(4)
        icrossdyadic_2s2s%a6b6(5,6) = T1%a6(5) * T2%a6(6)
        icrossdyadic_2s2s%a6b6(6,6) = T1%a6(3) * T2%a6(1)
        
       end function icrossdyadic_2s2s