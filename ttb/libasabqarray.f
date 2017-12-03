!      ------AS ABAQUS ARRAY SECTION-------------------
       function asabqarray_2s(T,i,j)
        implicit none
        
        type(Tensor2s), intent(in) :: T
        integer, intent(in) :: i
        integer, intent(in), optional :: j
        real(kind=8), dimension(i) :: asabqarray_2s
        integer :: i1
        
        asabqarray_2s(1:min(i,4)) = T%a6(1:min(i,4))
        
        if (i.ge.5) then
         asabqarray_2s(5) = T%a6(6)
        end if
        
        if (i.ge.6) then
         asabqarray_2s(6) = T%a6(5)
        endif
        
       end function asabqarray_2s
       
       function asabqarray_4s(T,i,j)
        implicit none
        
        type(Tensor4s), intent(in) :: T
        integer, intent(in) :: i,j
        real(kind=8), dimension(i,j) :: asabqarray_4s
        integer, dimension(6) :: imap
        integer :: i1,j1

        imap = (/1,2,3,4,6,5/)
        
        forall (i1=1:i,j1=1:j) asabqarray_4s(i1,j1) = 
     *            T%a6b6(imap(i1),imap(j1))
        
       end function asabqarray_4s