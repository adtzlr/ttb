       function tenstore_2s(T,w)
        implicit none
        
        integer, intent(in) :: w
        type(Tensor2s), intent(in) :: T
        type(Tensor2) :: tenstore_2s
        integer :: i
        
        tenstore_2s%ab = 0.d0
        do i=1,3
         tenstore_2s%ab(i,i) = T%a6(i)
        enddo
        tenstore_2s%ab(1,2) = T%a6(4)/dble(w)
        tenstore_2s%ab(2,3) = T%a6(5)/dble(w)
        tenstore_2s%ab(3,1) = T%a6(6)/dble(w)
        tenstore_2s%ab(2,1) = tenstore_2s%ab(1,2)
        tenstore_2s%ab(3,2) = tenstore_2s%ab(2,3)
        tenstore_2s%ab(1,3) = tenstore_2s%ab(3,1)

       end function tenstore_2s
       
       function tenstore_2(T,w)
        implicit none
        
        integer, intent(in) :: w
        type(Tensor2), intent(in) :: T
        type(Tensor2) :: tenstore_2
        
        tenstore_2%ab = T%ab

       end function tenstore_2