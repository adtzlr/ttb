module ttb_rotation
   use ttb_types
   use ttb_identity
   interface rotation_matrix
      module procedure rotation_2
   end interface
contains
   function rotation_2(phi, i)
      implicit none

      real(kind=dp), intent(in)     :: phi
      integer, intent(in)     :: i
      real(kind=dp), dimension(2, 2) :: R
      type(Tensor2)                :: rotation_2

      R = reshape((/cos(phi), sin(phi), &
                    -sin(phi), cos(phi)/), (/2, 2/))

      rotation_2 = identity2(rotation_2)

      if (i == 1) then
         rotation_2%ab(2:3, 2:3) = R
      else if (i == 3) then
         rotation_2%ab(1:2, 1:2) = R
      else !i == 2
         rotation_2%ab(1, 1) = R(1, 1)
         rotation_2%ab(3, 3) = R(2, 2)
         rotation_2%ab(1, 3) = R(2, 1)
         rotation_2%ab(3, 1) = R(1, 2)
      end if

   end function rotation_2
end module ttb_rotation
