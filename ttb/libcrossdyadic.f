       function crossdyadic_22(T1, T2)
        implicit none
        
        type(Tensor2), intent(in) :: T1, T2
        type(Tensor4) :: crossdyadic_22
        integer i, j, k, l
        
        forall(i=1:3,j=1:3,k=1:3,l=1:3) crossdyadic_22%abcd(i,j,k,l)
     *                                = (T1%ab(i,k) * T2%ab(j,l) + 
     *                                   T1%ab(i,l) * T2%ab(j,k))/2.d0
        
       end function crossdyadic_22
       
       function crossdyadic_2s2s(T1, T2)
       ! check if correct
       ! contraction of dual shear terms (4:6,i)
        implicit none
        
        type(Tensor2s), intent(in) :: T1, T2
        type(Tensor4s) :: crossdyadic_2s2s
        
        crossdyadic_2s2s%a6b6(1,1) = T1%a6(1) * T2%a6(1)
        crossdyadic_2s2s%a6b6(2,1) = T1%a6(4) * T2%a6(4)
        crossdyadic_2s2s%a6b6(3,1) = T1%a6(6) * T2%a6(6)
        crossdyadic_2s2s%a6b6(4,1) = T1%a6(1) * T2%a6(4)
        crossdyadic_2s2s%a6b6(5,1) = T1%a6(4) * T2%a6(6)
        crossdyadic_2s2s%a6b6(6,1) = T1%a6(6) * T2%a6(1)
        
        crossdyadic_2s2s%a6b6(1,2) = T1%a6(4) * T2%a6(4)
        crossdyadic_2s2s%a6b6(2,2) = T1%a6(2) * T2%a6(2)
        crossdyadic_2s2s%a6b6(3,2) = T1%a6(5) * T2%a6(5)
        crossdyadic_2s2s%a6b6(4,2) = T1%a6(4) * T2%a6(2)
        crossdyadic_2s2s%a6b6(5,2) = T1%a6(2) * T2%a6(5)
        crossdyadic_2s2s%a6b6(6,2) = T1%a6(5) * T2%a6(4)
        
        crossdyadic_2s2s%a6b6(1,3) = T1%a6(6) * T2%a6(6)
        crossdyadic_2s2s%a6b6(2,3) = T1%a6(5) * T2%a6(5)
        crossdyadic_2s2s%a6b6(3,3) = T1%a6(3) * T2%a6(3)
        crossdyadic_2s2s%a6b6(4,3) = T1%a6(6) * T2%a6(5)
        crossdyadic_2s2s%a6b6(5,3) = T1%a6(5) * T2%a6(3)
        crossdyadic_2s2s%a6b6(6,3) = T1%a6(3) * T2%a6(6)
        
        crossdyadic_2s2s%a6b6(1,4) = (T1%a6(1) * T2%a6(4)
     *                               +T1%a6(4) * T2%a6(1))/2.d0
        crossdyadic_2s2s%a6b6(2,4) = (T1%a6(4) * T2%a6(2)
     *                               +T1%a6(2) * T2%a6(4))/2.d0
        crossdyadic_2s2s%a6b6(3,4) = (T1%a6(6) * T2%a6(5)
     *                               +T1%a6(5) * T2%a6(6))/2.d0
        crossdyadic_2s2s%a6b6(4,4) = (T1%a6(1) * T2%a6(2)
     *                               +T1%a6(4) * T2%a6(4))/2.d0!*2.
        crossdyadic_2s2s%a6b6(5,4) = (T1%a6(4) * T2%a6(5)
     *                               +T1%a6(2) * T2%a6(6))/2.d0!*2.
        crossdyadic_2s2s%a6b6(6,4) = (T1%a6(6) * T2%a6(4)
     *                               +T1%a6(5) * T2%a6(1))/2.d0!*2.
     
        crossdyadic_2s2s%a6b6(1,5) = (T1%a6(6) * T2%a6(4)
     *                               +T1%a6(4) * T2%a6(6))/2.d0
        crossdyadic_2s2s%a6b6(2,5) = (T1%a6(5) * T2%a6(2)
     *                               +T1%a6(2) * T2%a6(5))/2.d0
        crossdyadic_2s2s%a6b6(3,5) = (T1%a6(3) * T2%a6(5)
     *                               +T1%a6(5) * T2%a6(3))/2.d0
        crossdyadic_2s2s%a6b6(4,5) = (T1%a6(4) * T2%a6(5)
     *                               +T1%a6(6) * T2%a6(2))/2.d0!*2.
        crossdyadic_2s2s%a6b6(5,5) = (T1%a6(2) * T2%a6(3)
     *                               +T1%a6(5) * T2%a6(5))/2.d0!*2.
        crossdyadic_2s2s%a6b6(6,5) = (T1%a6(5) * T2%a6(6)
     *                               +T1%a6(3) * T2%a6(4))/2.d0!*2.
     
        crossdyadic_2s2s%a6b6(1,6) = (T1%a6(1) * T2%a6(6)
     *                               +T1%a6(6) * T2%a6(1))/2.d0
        crossdyadic_2s2s%a6b6(2,6) = (T1%a6(4) * T2%a6(5)
     *                               +T1%a6(5) * T2%a6(4))/2.d0
        crossdyadic_2s2s%a6b6(3,6) = (T1%a6(6) * T2%a6(3)
     *                               +T1%a6(3) * T2%a6(6))/2.d0
        crossdyadic_2s2s%a6b6(4,6) = (T1%a6(6) * T2%a6(4)
     *                               +T1%a6(1) * T2%a6(5))/2.d0!*2.
        crossdyadic_2s2s%a6b6(5,6) = (T1%a6(5) * T2%a6(6)
     *                               +T1%a6(4) * T2%a6(3))/2.d0!*2.
        crossdyadic_2s2s%a6b6(6,6) = (T1%a6(3) * T2%a6(1)
     *                               +T1%a6(6) * T2%a6(6))/2.d0!*2.
        
       end function crossdyadic_2s2s