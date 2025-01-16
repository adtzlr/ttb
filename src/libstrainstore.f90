!        function str2ten_2(E,ndi,nshear,ngens)
!         implicit none
!
!         integer :: ndi,nshear,ngens
!         real(kind=dp), dimension(ngens) :: E
!         type(Tensor2) :: str2ten_2
!         integer, dimension(3) :: ii, jj
!         integer :: i
!
!         str2ten_2 = Identity2(str2ten_2)
!
!         do i=1,ndi
!          str2ten_2%ab(i,i) = E(i)
!         enddo
!
!         ii = (/1,2,3/)
!         jj = (/2,3,1/)
!
!         do i=1,nshear
!          str2ten_2%ab(ii(i),jj(i)) = E(i+ndi)/2.
!         end do

!        end function str2ten_2
module ttb_strainstore
   use ttb_types
   use ttb_identity

   interface strain
      ! module procedure str2ten_2
      module procedure str2ten_2s
   end interface
contains

   function str2ten_2s(E, ndi, nshear, ngens)
      implicit none

      integer :: ndi, nshear, ngens
      real(kind=dp), dimension(ngens) :: E
      type(Tensor2s) :: str2ten_2s
      integer :: i

      str2ten_2s = Identity2(str2ten_2s)

      do i = 1, ndi
         str2ten_2s%a6(i) = E(i)
      end do

      do i = 1, nshear
         str2ten_2s%a6(i + 3) = E(i + ndi)/2.
      end do

   end function str2ten_2s
end module ttb_strainstore
