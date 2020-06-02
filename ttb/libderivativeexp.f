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

       function dexp_2(T)
        implicit none
        
        type(Tensor2), intent(in) :: T
        type(Tensor2) :: Eye,N_i,N_j,N_r
        type(Tensor4) :: dexp_2
        real(kind=8)  :: tol,I1,I2,I3,g_i
        integer :: i,j,r
        
        tol = 1.0d-8
        i = 2

        Eye = identity2(Eye)
        dexp_2 = Eye.cdya.Eye
        
        I1 = T**Eye
        I2 = 5.0d-1*(I1**2-T**T)
        I3 = det(T)
        
        N_i = Eye
        do while (norm(N_i)/fact(i) .gt. tol)
         g_i = 1./fact(i)
         if (i >= 3) then
           ! Cayley-Hamilton recursive formula
           N_i = I1 * T**(i-1) - I2 * T**(i-2) + I3 * T**(i-3)
         else
           N_i = T**i
         end if
         
         do r=0,i-1
          j = i-1-r
          
          if (j >= 3) then
           ! Cayley-Hamilton recursive formula
           N_j = I1 * T**(j-1) - I2 * T**(j-2) + I3 * T**(j-3)
          else
           N_j = T**j
          end if
          
          if (r >= 3) then
           ! Cayley-Hamilton recursive formula
           N_r = I1 * T**(r-1) - I2 * T**(r-2) + I3 * T**(r-3)
          else
           N_r = T**r
          end if
          
          dexp_2 = dexp_2 + g_i * (N_j.cdya.N_r)
          
         end do
         
         i = i+1
        end do
     
       end function dexp_2
       
       function dexp_2s(T)
        implicit none
        
        type(Tensor2s), intent(in) :: T
        type(Tensor2s) :: Eye,N_i,N_j,N_r
        type(Tensor4s) :: dexp_2s
        real(kind=8)  :: tol,I1,I2,I3,g_i
        integer :: i,j,r
        
        tol = 1.0d-8
        i = 2

        Eye = identity2(Eye)
        dexp_2s = Eye.cdya.Eye
        
        I1 = T**Eye
        I2 = 5.0d-1*(I1**2-T**T)
        I3 = det(T)
        
        N_i = Eye
        do while (norm(N_i)/fact(i) .gt. tol)
         g_i = 1./fact(i)
         if (i >= 3) then
           ! Cayley-Hamilton recursive formula
           N_i = I1 * T**(i-1) - I2 * T**(i-2) + I3 * T**(i-3)
         else
           N_i = T**i
         end if
         
         do r=0,i-1
          j = i-1-r
          
          if (j >= 3) then
           ! Cayley-Hamilton recursive formula
           N_j = I1 * T**(j-1) - I2 * T**(j-2) + I3 * T**(j-3)
          else
           N_j = T**j
          end if
          
          if (r >= 3) then
           ! Cayley-Hamilton recursive formula
           N_r = I1 * T**(r-1) - I2 * T**(r-2) + I3 * T**(r-3)
          else
           N_r = T**r
          end if
          
          dexp_2s = dexp_2s + g_i * (N_j.cdya.N_r)
          
         end do
         
         i = i+1
        end do

       end function dexp_2s