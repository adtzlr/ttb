c Store a second order stress tensor into components for vectorization
       subroutine ten_2_to_sigX(ten_2, sig1_i, sig2_i, sig3_i,
     &                               sig4_i, sig5_i, sig6_i)
        implicit none
        
        type(Tensor2), intent(in) :: ten_2
        real sig1_i, sig2_i, sig3_i, sig4_i, sig5_i, sig6_i
        real sig(6)
        
        sig(1:6) = asarray(voigt(ten_2),6)
        sig1_i=sig(1)
        sig2_i=sig(2)
        sig3_i=sig(3)
        sig4_i=sig(4)
        sig5_i=sig(5)
        sig6_i=sig(6)
        return
      end
      
