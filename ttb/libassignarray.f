       subroutine assignarr_2s(T,A)
        implicit none
        
        type(Tensor2s), intent(inout) :: T
        real(kind=8), dimension(6), intent(in) :: A
        
        T%a6 = A
        
       end subroutine assignarr_2s
       
       subroutine assignarr_2sr4(T,A)
        implicit none
        
        type(Tensor2s), intent(inout) :: T
        real(kind=4), dimension(6), intent(in) :: A
        
        T%a6 = dble(A)
        
       end subroutine assignarr_2sr4
       
       subroutine assignarr_4s(T,A)
        implicit none
        
        type(Tensor4s), intent(inout) :: T
        real(kind=8), dimension(6,6), intent(in) :: A
        
        T%a6b6 = A
        
       end subroutine assignarr_4s
       
       subroutine assignarr_4sr4(T,A)
        implicit none
        
        type(Tensor4s), intent(inout) :: T
        real(kind=4), dimension(6,6), intent(in) :: A
        
        T%a6b6 = dble(A)
        
       end subroutine assignarr_4sr4
       
       subroutine assignarr_1(T,A)
        implicit none
        
        type(Tensor1), intent(inout) :: T
        real(kind=8), dimension(3), intent(in) :: A
        
        T%a = A
        
       end subroutine assignarr_1
       
       subroutine assignarr_1r4(T,A)
        implicit none
        
        type(Tensor1), intent(inout) :: T
        real(kind=4), dimension(3), intent(in) :: A
        
        T%a = dble(A)
        
       end subroutine assignarr_1r4
       
       subroutine assignarr_2(T,A)
        implicit none
        
        type(Tensor2), intent(inout) :: T
        real(kind=8), dimension(3,3), intent(in) :: A
        
        T%ab = A
        
       end subroutine assignarr_2
       
       subroutine assignarr_2r4(T,A)
        implicit none
        
        type(Tensor2), intent(inout) :: T
        real(kind=4), dimension(3,3), intent(in) :: A
        
        T%ab = dble(A)
        
       end subroutine assignarr_2r4
       
       subroutine assignarr_4(T,A)
        implicit none
        
        type(Tensor4), intent(inout) :: T
        real(kind=8), dimension(3,3,3,3), intent(in) :: A
        
        T%abcd = A
        
       end subroutine assignarr_4
       
       subroutine assignarr_4r4(T,A)
        implicit none
        
        type(Tensor4), intent(inout) :: T
        real(kind=4), dimension(3,3,3,3), intent(in) :: A
        
        T%abcd = dble(A)
        
       end subroutine assignarr_4r4