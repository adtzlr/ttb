module ttb_asabqarray
   use ttb_types
   interface asabqarray
      module procedure asabqarray_2s
      module procedure asabqarray_4s
   end interface
contains
!      ------AS ABAQUS ARRAY SECTION-------------------
   function asabqarray_2s(T, i)
      !function asabqarray_2s(T, i,j)
      implicit none

      type(Tensor2s), intent(in) :: T
      integer, intent(in) :: i
      !integer, intent(in), optional :: j
      real(kind=dp), dimension(i) :: asabqarray_2s

      asabqarray_2s(1:min(i, 4)) = T%a6(1:min(i, 4))

      if (i .ge. 5) then
         asabqarray_2s(5) = T%a6(6)
      end if

      if (i .ge. 6) then
         asabqarray_2s(6) = T%a6(5)
      end if

   end function asabqarray_2s

   function asabqarray_4s(T, i, j)
      implicit none

      type(Tensor4s), intent(in) :: T
      integer, intent(in) :: i, j
      real(kind=dp), dimension(i, j) :: asabqarray_4s
      integer, dimension(6) :: imap
      integer :: i1, j1

      imap = (/1, 2, 3, 4, 6, 5/)

      ! forall (i1=1:i, j1=1:j) asabqarray_4s(i1, j1) = &
      !    T%a6b6(imap(i1), imap(j1))
      do i1 = 1, i
         do j1 = 1, j
            asabqarray_4s(i1, j1) = T%a6b6(imap(i1), imap(j1))
         end do
      end do

   end function asabqarray_4s
end module ttb_asabqarray
