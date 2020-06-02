       ! Exponential Map of Tensor Arguments
       ! --------------------------------------------------------
       ! Algorithmic Sources
       ! Miehe(2002): Homogenization of inelastic solid materials
       !    at (nite strains based on incremental minimization
       !    principles. Application
       !    to the texture analysis of polycrystals
        
       ! --------------------------------------------------------
       ! Author: A. Dutzler, Graz University of Technology
       ! Date:   2018-04-06

       function exp_2(T)
        implicit none
        
        type(Tensor2), intent(in) :: T
        type(Tensor2) :: exp_2,Eye,N_i
        real(kind=8)  :: tol,I1,I2,I3
        integer :: i
        
        tol = 1.0d-8
        i = 3

        Eye = identity2(Eye)
        exp_2 = Eye + T + 5.0d-1 * (T*T)
        
        I1 = T**Eye
        I2 = 5.0d-1*(I1**2-T**T)
        I3 = det(T)
        
        N_i = Eye
        do while (norm(N_i)/fact(i) .gt. tol)
         ! Cayley-Hamilton recursive formula
         N_i = I1 * T**(i-1) - I2 * T**(i-2) + I3 * T**(i-3)
         exp_2 = exp_2 + 1./fact(i) * N_i
         
         i = i+1
        end do
     
       end function exp_2
       
       function exp_2s(T)
        implicit none
        
        type(Tensor2s), intent(in) :: T
        type(Tensor2s) :: exp_2s,Eye,N_i
        real(kind=8)  :: tol,I1,I2,I3
        integer :: i
        
        
        tol = 1.0d-8
        i = 3

        Eye = identity2(Eye)
        exp_2s = Eye + T + 0.5 * (T*T)
        
        I1 = T**Eye
        I2 = 0.5*(I1**2-T**T)
        I3 = det(T)
        
        N_i = Eye
        do while (norm(N_i)/fact(i) .gt. tol)
         ! Cayley-Hamilton recursive formula
         N_i = I1 * T**(i-1) - I2 * T**(i-2) + I3 * T**(i-3)
         exp_2s = exp_2s + 1./fact(i) * N_i
         
         i = i+1
        end do
     
       end function exp_2s
       