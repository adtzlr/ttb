c Store a fourth order tensor as a list with 36 entries       
       function ten_4_to_list_36(T)
        !implicit none
        
       ! @todo maybe check size of ten_4_to_list_36
        type(Tensor4), intent(in) :: T
        real(kind=8), dimension(36) :: ten_4_to_list_36
        real, dimension(6,6) :: es
        integer :: i,j
        es(1:6,1:6) = asarray(asvoigt(T),6,6)

        forall(i=1:6,j=1:6) ten_4_to_list_36(j+(i-1)*6) = es(i,j)

      end function ten_4_to_list_36

c Retrieve from a list with 36 entries the 6x6 matrix     
      function list_36_to_array_6x6(list)
        !implicit none
        
        real(kind=8), dimension(36) :: list
        real, dimension(6,6) :: list_36_to_array_6x6
        integer :: i,j

        forall(i=1:6,j=1:6) list_36_to_array_6x6(i,j) = list(j+(i-1)*6)

      end function list_36_to_array_6x6
      
       !function list_36_to_ten_4(list)
       ! implicit none
       ! 
       ! type(Tensor4) :: list_36_to_ten_4
       ! real, dimension(36), intent(in) :: list
       ! real, dimension(6,6) :: es
       ! integer :: i,j
       ! 
       ! forall(i=1:6,j=1:6) es(i,j) = list(j+(i-1)*6)
       !
       ! list_36_to_ten_4 = symstore_4sa(es)
       !
       !end function list_36_to_ten_4