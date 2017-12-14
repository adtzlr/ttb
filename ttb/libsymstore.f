       function symstore_2s(T)
        implicit none
        
        integer :: w
        type(Tensor2s), intent(in) :: T
        type(Tensor2s) :: symstore_2s

        symstore_2s%a6 = T%a6
       end function symstore_2s
        
       function symstore_2sa(T)
        implicit none
        
        integer :: w
        real(kind=8), dimension(6), intent(in) :: T
        type(Tensor2s) :: symstore_2sa

        symstore_2sa%a6 = T

       end function symstore_2sa
       
       function symstore_4s(T)
        implicit none
        
        integer :: w1,w2
        type(Tensor4s), intent(in) :: T
        type(Tensor4s) :: symstore_4s

        symstore_4s%a6b6 = T%a6b6

       end function symstore_4s
       
       function symstore_4sa(T)
        implicit none
        
        integer :: w1,w2
        real(kind=8), dimension(6,6), intent(in) :: T
        type(Tensor4s) :: symstore_4sa

        symstore_4sa%a6b6 = T

       end function symstore_4sa

       function symstore_2(T)
        implicit none
        
        integer :: w
        type(Tensor2), intent(in) :: T
        type(Tensor2s) :: symstore_2
        integer :: i
        
        w = 1
        
        symstore_2%a6 = 0.d0
        do i=1,3
         symstore_2%a6(i) = T%ab(i,i)
        enddo
        symstore_2%a6(4) = T%ab(1,2)*dble(w)
        symstore_2%a6(5) = T%ab(2,3)*dble(w)
        symstore_2%a6(6) = T%ab(3,1)*dble(w)

       end function symstore_2
       
       function symstore_4(T)
        implicit none
        
        integer :: v1,v2
        type(Tensor4), intent(in) :: T
        type(Tensor4s) :: symstore_4
        real(kind=8) :: w
        integer :: i,j
        
        v1 = 1
        v2 = 1
        w = dble(v1)
        
        symstore_4%a6b6 = 0.d0
        do i=1,3
         do j=1,3
          symstore_4%a6b6(i,j) = T%abcd(i,i,j,j)
         enddo
        enddo
        
        symstore_4%a6b6(4,4) = T%abcd(1,2,1,2)!+T%abcd(2,1,1,2))/2.d0*w
        symstore_4%a6b6(5,5) = T%abcd(2,3,2,3)!+T%abcd(3,2,2,3))/2.d0*w
        symstore_4%a6b6(6,6) = T%abcd(3,1,3,1)!+T%abcd(1,3,3,1))/2.d0*w
        
        do i=1,3
         symstore_4%a6b6(i,4) = T%abcd(i,i,1,2)
         symstore_4%a6b6(i,5) = T%abcd(i,i,2,3)
         symstore_4%a6b6(i,6) = T%abcd(i,i,3,1)
         symstore_4%a6b6(4,i) = T%abcd(1,2,i,i)
         symstore_4%a6b6(5,i) = T%abcd(2,3,i,i)
         symstore_4%a6b6(6,i) = T%abcd(3,1,i,i)
        enddo
        
        symstore_4%a6b6(4,5) = T%abcd(1,2,2,3)!+T%abcd(2,1,2,3))/2.d0*w
        symstore_4%a6b6(4,6) = T%abcd(1,2,3,1)!+T%abcd(2,1,3,1))/2.d0*w
        
        symstore_4%a6b6(5,4) = T%abcd(2,3,1,2)!+T%abcd(3,2,1,2))/2.d0*w
        symstore_4%a6b6(5,6) = T%abcd(2,3,3,1)!+T%abcd(3,2,3,1))/2.d0*w
        
        symstore_4%a6b6(6,4) = T%abcd(3,1,1,2)!+T%abcd(1,3,1,2))/2.d0*w
        symstore_4%a6b6(6,5) = T%abcd(3,1,2,3)!+T%abcd(1,3,2,3))/2.d0*w
        
       end function symstore_4