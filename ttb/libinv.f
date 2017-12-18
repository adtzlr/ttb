       function inv_2(T)
        implicit none
        
        type(Tensor2), intent(in) :: T
        type(Tensor2) :: inv_2
        real(kind=8) :: detT
        
        detT = det(T)
        
        inv_2%ab(1,1)=+1./detT*(T%ab(2,2)*T%ab(3,3)-T%ab(2,3)*T%ab(3,2))
        inv_2%ab(2,1)=-1./detT*(T%ab(2,1)*T%ab(3,3)-T%ab(2,3)*T%ab(3,1))
        inv_2%ab(3,1)=+1./detT*(T%ab(2,1)*T%ab(3,2)-T%ab(2,2)*T%ab(3,1))
        inv_2%ab(1,2)=-1./detT*(T%ab(1,2)*T%ab(3,3)-T%ab(1,3)*T%ab(3,2))
        inv_2%ab(2,2)=+1./detT*(T%ab(1,1)*T%ab(3,3)-T%ab(1,3)*T%ab(3,1))
        inv_2%ab(3,2)=-1./detT*(T%ab(1,1)*T%ab(3,2)-T%ab(1,2)*T%ab(3,1))
        inv_2%ab(1,3)=+1./detT*(T%ab(1,2)*T%ab(2,3)-T%ab(1,3)*T%ab(2,2))
        inv_2%ab(2,3)=-1./detT*(T%ab(1,1)*T%ab(2,3)-T%ab(1,3)*T%ab(2,1))
        inv_2%ab(3,3)=+1./detT*(T%ab(1,1)*T%ab(2,2)-T%ab(1,2)*T%ab(2,1))
        
       end function inv_2
       
       function inv_2s(T)
        implicit none
        
        type(Tensor2s), intent(in) :: T
        type(Tensor2s) :: inv_2s
        real(kind=8) :: v
        real(kind=8) :: detT
        
        v = 1.0
        ! v=2 for strain
        
        detT = det(T)
        
        inv_2s%a6(1)=+1./detT*(T%a6(2)*T%a6(3)  -T%a6(5)*T%a6(5) /v**2)
        inv_2s%a6(4)=- v/detT*(T%a6(4)*T%a6(3)/v-T%a6(5)*T%a6(6) /v**2)
        inv_2s%a6(6)=+ v/detT*(T%a6(4)*T%a6(5)  -T%a6(2)*T%a6(6))/v**2
        inv_2s%a6(2)=+1./detT*(T%a6(1)*T%a6(3)  -T%a6(6)*T%a6(6) /v**2)
        inv_2s%a6(5)=- v/detT*(T%a6(1)*T%a6(5)/v-T%a6(4)*T%a6(6) /v**2)
        inv_2s%a6(3)=+1./detT*(T%a6(1)*T%a6(2)  -T%a6(4)*T%a6(4) /v**2)
        
       end function inv_2s
       
       function inv2d(T,detT)
        implicit none
        
        type(Tensor2), intent(in) :: T
        type(Tensor2) :: inv2d
        real(kind=8) :: detT
        
        inv2d%ab(1,1)=+1./detT*(T%ab(2,2)*T%ab(3,3)-T%ab(2,3)*T%ab(3,2))
        inv2d%ab(2,1)=-1./detT*(T%ab(2,1)*T%ab(3,3)-T%ab(2,3)*T%ab(3,1))
        inv2d%ab(3,1)=+1./detT*(T%ab(2,1)*T%ab(3,2)-T%ab(2,2)*T%ab(3,1))
        inv2d%ab(1,2)=-1./detT*(T%ab(1,2)*T%ab(3,3)-T%ab(1,3)*T%ab(3,2))
        inv2d%ab(2,2)=+1./detT*(T%ab(1,1)*T%ab(3,3)-T%ab(1,3)*T%ab(3,1))
        inv2d%ab(3,2)=-1./detT*(T%ab(1,1)*T%ab(3,2)-T%ab(1,2)*T%ab(3,1))
        inv2d%ab(1,3)=+1./detT*(T%ab(1,2)*T%ab(2,3)-T%ab(1,3)*T%ab(2,2))
        inv2d%ab(2,3)=-1./detT*(T%ab(1,1)*T%ab(2,3)-T%ab(1,3)*T%ab(2,1))
        inv2d%ab(3,3)=+1./detT*(T%ab(1,1)*T%ab(2,2)-T%ab(1,2)*T%ab(2,1))
        
       end function inv2d
       
       function inv2sd(T,detT)
        implicit none
        
        type(Tensor2s), intent(in) :: T
        type(Tensor2s) :: inv2sd
        real(kind=8) :: v
        real(kind=8):: detT
        
        v = 1.0
        ! v=2 for strain
        
        inv2sd%a6(1)=+1./detT*(T%a6(2)*T%a6(3)  -T%a6(5)*T%a6(5) /v**2)
        inv2sd%a6(4)=- v/detT*(T%a6(4)*T%a6(3)/v-T%a6(5)*T%a6(6) /v**2)
        inv2sd%a6(6)=+ v/detT*(T%a6(4)*T%a6(5)  -T%a6(2)*T%a6(6))/v**2
        inv2sd%a6(2)=+1./detT*(T%a6(1)*T%a6(3)  -T%a6(6)*T%a6(6) /v**2)
        inv2sd%a6(5)=- v/detT*(T%a6(1)*T%a6(5)/v-T%a6(4)*T%a6(6) /v**2)
        inv2sd%a6(3)=+1./detT*(T%a6(1)*T%a6(2)  -T%a6(4)*T%a6(4) /v**2)
        
       end function inv2sd