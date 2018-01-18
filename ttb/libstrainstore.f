C        function str2ten_2(E,ndi,nshear,ngens)
C         implicit none
C         
C         integer :: ndi,nshear,ngens
C         real(kind=8), dimension(ngens) :: E
C         type(Tensor2) :: str2ten_2
C         integer, dimension(3) :: ii, jj
C         integer :: i
C         
C         str2ten_2 = Identity2(str2ten_2)
C         
C         do i=1,ndi
C          str2ten_2%ab(i,i) = E(i)
C         enddo
C         
C         ii = (/1,2,3/)
C         jj = (/2,3,1/)
C         
C         do i=1,nshear
C          str2ten_2%ab(ii(i),jj(i)) = E(i+ndi)/2.
C         end do

C        end function str2ten_2
       
       function str2ten_2s(E,ndi,nshear,ngens)
        implicit none
        
        integer :: ndi, nshear, ngens
        real(kind=8), dimension(ngens) :: E
        type(Tensor2s) :: str2ten_2s
        integer :: i
        
        str2ten_2s = Identity2(str2ten_2s)
        
        do i=1,ndi
         str2ten_2s%a6(i) = E(i)
        enddo
        
        do i=1,nshear
         str2ten_2s%a6(i+3) = E(i+ndi)/2.
        end do

       end function str2ten_2s