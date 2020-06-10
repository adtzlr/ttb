c LSTC stores the deformation gradient in a vector, but with
c indices running as noted below (LS-Dyna User manual Appendix-A "Deformation gradient")
      function vec9_LSTC_to_unsymTensor_2(vec9)
        implicit none
        
        real(kind=8), dimension(6), intent(in) :: vec9
        type(Tensor2) :: vec9_LSTC_to_unsymTensor_2
        
        vec9_LSTC_to_unsymTensor_2%ab(1,1) = vec9(1)
        vec9_LSTC_to_unsymTensor_2%ab(2,1) = vec9(2)
        vec9_LSTC_to_unsymTensor_2%ab(3,1) = vec9(3)
        vec9_LSTC_to_unsymTensor_2%ab(1,2) = vec9(4)
        vec9_LSTC_to_unsymTensor_2%ab(2,2) = vec9(5)
        vec9_LSTC_to_unsymTensor_2%ab(3,2) = vec9(6)
        vec9_LSTC_to_unsymTensor_2%ab(1,3) = vec9(7)
        vec9_LSTC_to_unsymTensor_2%ab(2,3) = vec9(8)
        vec9_LSTC_to_unsymTensor_2%ab(3,3) = vec9(9)

      end function vec9_LSTC_to_unsymTensor_2
      
c The inverse function to store an unsymmetric second order tensor as the LSTC-type
c list. (Only for the sake of completeness, usually not needed.)
      function unsymTensor_2_to_vec9_LSTC(unsymTen2)
        implicit none
        
        real(kind=8), dimension(6) :: unsymTensor_2_to_vec9_LSTC
        type(Tensor2), intent(in) :: unsymTen2
        
        unsymTensor_2_to_vec9_LSTC(1) = unsymTen2%ab(1,1)
        unsymTensor_2_to_vec9_LSTC(2) = unsymTen2%ab(2,1) 
        unsymTensor_2_to_vec9_LSTC(3) = unsymTen2%ab(3,1) 
        unsymTensor_2_to_vec9_LSTC(4) = unsymTen2%ab(1,2) 
        unsymTensor_2_to_vec9_LSTC(5) = unsymTen2%ab(2,2) 
        unsymTensor_2_to_vec9_LSTC(6) = unsymTen2%ab(3,2) 
        unsymTensor_2_to_vec9_LSTC(7) = unsymTen2%ab(1,3)
        unsymTensor_2_to_vec9_LSTC(8) = unsymTen2%ab(2,3) 
        unsymTensor_2_to_vec9_LSTC(9) = unsymTen2%ab(3,3) 

      end function unsymTensor_2_to_vec9_LSTC