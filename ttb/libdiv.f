!      ------REAL(KIND=8)--------------------------------------
       function div_10(T, w)
        implicit none
        
        real(kind=8), intent(in) :: w
        type(Tensor1), intent(in) :: T
        type(Tensor1) :: div_10

        div_10%a = T%a / w
        
       end function div_10
       
       function div_20(T, w)
        implicit none
        
        real(kind=8), intent(in) :: w
        type(Tensor2), intent(in) :: T
        type(Tensor2) :: div_20

        div_20%ab = T%ab / w
        
       end function div_20
       
       function div_20s(T, w)
        implicit none
        
        real(kind=8), intent(in) :: w
        type(Tensor2s), intent(in) :: T
        type(Tensor2s) :: div_20s

        div_20s%a6 = T%a6 / w
        
       end function div_20s

       function div_40(T, w)
        implicit none
        
        real(kind=8), intent(in) :: w
        type(Tensor4), intent(in) :: T
        type(Tensor4) :: div_40

        div_40%abcd = T%abcd / w
        
       end function div_40
       
       function div_40s(T, w)
        implicit none
        
        real(kind=8), intent(in) :: w
        type(Tensor4s), intent(in) :: T
        type(Tensor4s) :: div_40s

        div_40s%a6b6 = T%a6b6 / w
        
       end function div_40s
!      ------REAL(KIND=4)----------------------------------------
       function div_10_r4(T, w)
        implicit none
        
        real(kind=4), intent(in) :: w
        type(Tensor1), intent(in) :: T
        type(Tensor1) :: div_10_r4

        div_10_r4%a = T%a / dble(w)
        
       end function div_10_r4
       
       function div_20_r4(T, w)
        implicit none
        
        real(kind=4), intent(in) :: w
        type(Tensor2), intent(in) :: T
        type(Tensor2) :: div_20_r4

        div_20_r4%ab = T%ab / dble(w)
        
       end function div_20_r4
       
       function div_20s_r4(T, w)
        implicit none
        
        real(kind=4), intent(in) :: w
        type(Tensor2s), intent(in) :: T
        type(Tensor2s) :: div_20s_r4

        div_20s_r4%a6 = T%a6 / dble(w)
        
       end function div_20s_r4

       function div_40_r4(T, w)
        implicit none
        
        real(kind=4), intent(in) :: w
        type(Tensor4), intent(in) :: T
        type(Tensor4) :: div_40_r4

        div_40_r4%abcd = T%abcd / dble(w)
        
       end function div_40_r4
       
       function div_40s_r4(T, w)
        implicit none
        
        real(kind=4), intent(in) :: w
        type(Tensor4s), intent(in) :: T
        type(Tensor4s) :: div_40s_r4

        div_40s_r4%a6b6 = T%a6b6 / dble(w)
        
       end function div_40s_r4