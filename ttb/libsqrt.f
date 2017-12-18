       function sqrt_1(T)
        implicit none
        
        type(Tensor1), intent(in) :: T
        type(Tensor1) :: sqrt_1

        sqrt_1%a = dsqrt(T%a)
        
       end function sqrt_1

       function stretch_2(T)
        ! Source:
        !
        ! Franca, L.P. (1989): AN ALGORITHM TO COMPUTE
        ! THE SQUARE ROOT OF A POSITIVE DEFINITE MATRIX
        ! 
        implicit none
        
        type(Tensor2), intent(in) :: T
        type(Tensor2) :: stretch_2
        
        real(kind=8) :: I_T,II_T,III_T,I_U,II_U,III_U,k,l,lam,phi

        ! Invariants of T
        I_T = tr(T)
        II_T = 0.5*(I_T**2-T**T)
        III_T = det(T)
        k = I_T**2-3.*II_T
        
        ! Isotropy check
        if (dabs(k).le.1.0d-8) then
         lam = (I_T/3.)**(1./2.)
         stretch_2 = lam * identity2(T)
         return
        end if
        
        ! Calculate largest eigenvalues
        l = I_T**3 - 9./2. * I_T*II_T + 27./2. * III_T
        phi = dacos(l/k**(3./2.))
        lam = dsqrt(1./3.*(I_T+2*k**(1./2.)*dcos(phi/3.)))
        
        ! Invariants of U
        III_U = (III_T)**(1./2.)
        I_U = lam + dsqrt(-lam**2+I_T+2.*III_U/lam)
        II_U = (I_U**2-I_T)/2.
        
        print *, 'test', l,k,1-l**2/k**3
        
        stretch_2 = 1./(I_U*II_U-III_U)
     *           *(I_U*III_U*identity2(T) + (I_U**2-II_U)*T-T**2)
        
       end function stretch_2
       
       function stretch_2s(T)
        ! Source:
        !
        ! Franca, L.P. (1989): AN ALGORITHM TO COMPUTE
        ! THE SQUARE ROOT OF A POSITIVE DEFINITE MATRIX
        ! 
        implicit none
        
        type(Tensor2s), intent(in) :: T
        type(Tensor2s) :: stretch_2s
        
        real(kind=8) :: I_T,II_T,III_T,I_U,II_U,III_U,k,l,lam,phi

        ! Invariants of T
        I_T = tr(T)
        II_T = 0.5*(I_T**2-tr(T*T))
        III_T = det(T)
        k = I_T**2-3.*II_T
        
        ! Isotropy check
        if (k.le.1.0d-8) then
         lam = (I_T/3.)**(1./2.)
         stretch_2s = lam * identity2(T)
         return
        end if
        
        ! Calculate largest eigenvalues
        l = I_T**3 - 9./2. * I_T*II_T + 27./2. * III_T
        phi = dacos(l/k**(3./2.))
        lam = dsqrt(1./3.*(I_T+2*k**(1./2.)*dcos(phi/3.)))
        
        ! Invariants of U
        III_U = (III_T)**(1./2.)
        I_U = lam + dsqrt(-lam**2+I_T+2.*III_U/lam)
        II_U = (I_U**2-I_T)/2.

        stretch_2s = 1./(I_U*II_U-III_U)
     *           *(I_U*III_U*identity2(T) + (I_U**2-II_U)*T-T*T)
        
       end function stretch_2s