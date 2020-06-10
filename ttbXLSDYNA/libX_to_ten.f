c Retrieve the stress tensor from the vectorization
       function sigX_to_ten_2(sig1_i, sig2_i, sig3_i,
     &                        sig4_i, sig5_i, sig6_i)
        implicit none
        
        type(Tensor2) :: sigX_to_ten_2
        real sig1_i, sig2_i, sig3_i, sig4_i, sig5_i, sig6_i
        real sig(6)
        
        sig(1)=sig1_i
        sig(2)=sig2_i
        sig(3)=sig3_i
        sig(4)=sig4_i
        sig(5)=sig5_i
        sig(6)=sig6_i
        sigX_to_ten_2 = symstore_2sa(sig)

      end function sigX_to_ten_2

c Retrieve the strain tensor from the vectorization      
      function dX_to_ten_2(d1_i, d2_i, d3_i,
     &                     d4_i, d5_i, d6_i)
        implicit none
        
        type(Tensor2) :: dX_to_ten_2
        real d1_i, d2_i, d3_i, d4_i, d5_i, d6_i
        real eps(6)
        
       eps(1)=d1_i
       eps(2)=d2_i
       eps(3)=d3_i
       eps(4)=d4_i
       eps(5)=d5_i
       eps(6)=d6_i  
       dX_to_ten_2 = str2ten_2s(eps,3,3,6)

       end function dX_to_ten_2