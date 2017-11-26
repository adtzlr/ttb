       function dyadic_11(T1, T2)
        implicit none
        
        type(Tensor1), intent(in) :: T1, T2
        type(Tensor2) :: dyadic_11
        integer i, j
        
        forall(i=1:3,j=1:3) dyadic_11%ab(i,j) = T1%a(i) * T2%a(j)
        
       end function dyadic_11
       
       function dyadic_22(T1, T2)
        implicit none
        
        type(Tensor2), intent(in) :: T1, T2
        type(Tensor4) :: dyadic_22
        integer i, j, k, l
        
        forall(i=1:3,j=1:3,k=1:3,l=1:3) dyadic_22%abcd(i,j,k,l)
     *                                = T1%ab(i,j) * T2%ab(k,l)
        
       end function dyadic_22
       
       function dyadic_2s2s(T1, T2)
        implicit none
        
        type(Tensor2s), intent(in) :: T1, T2
        type(Tensor4s) :: dyadic_2s2s
        integer i, j
        
        forall(i=1:6,j=1:6) dyadic_2s2s%a6b6(i,j) = T1%a6(i) * T2%a6(j)
        
       end function dyadic_2s2s