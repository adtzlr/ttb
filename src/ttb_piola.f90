module ttb_piola
   use ttb_types
   use ttb_tensorstore
   use ttb_symstore
   use ttb_transpose
   use ttb_cdya
   use ttb_dot
   use ttb_ddot
   interface piola
      module procedure piola2
      module procedure piola2s
      module procedure piola4
      module procedure piola4s
   end interface
contains
   function piola2(F, T)
      implicit none

      type(Tensor2), intent(in) :: T, F
      type(Tensor2) :: piola2

      piola2 = F*T*transpose(F)

   end function piola2

   function piola2s(F, T)
      implicit none

      type(Tensor2s), intent(in) :: T
      type(Tensor2), intent(in) :: F
      type(Tensor2s) :: piola2s

      piola2s = symstore(F*tensorstore(T)*transpose(F))

   end function piola2s

   function piola4(F, T)
      implicit none

      type(Tensor2), intent(in) :: F
      type(Tensor4), intent(in) :: T
      type(Tensor4) :: piola4
      integer :: i, j, k, l, ii, jj, kk, ll

      piola4%abcd = 0.d0
      do i = 1, 3
         do j = 1, 3
            do k = 1, 3
               do l = 1, 3
                  do ii = 1, 3
                     do jj = 1, 3
                        do kk = 1, 3
                           do ll = 1, 3
                              piola4%abcd(i, j, k, l) = piola4%abcd(i, j, k, l) + &
                                                        F%ab(i, ii)*F%ab(j, jj)*F%ab(k, kk)*F%ab(l, ll) &
                                                        *T%abcd(ii, jj, kk, ll)
                           end do
                        end do
                     end do
                  end do
               end do
            end do
         end do
      end do

   end function piola4

   function piola4s(F, T)
      implicit none

      type(Tensor2), intent(in) :: F
      type(Tensor4s), intent(in) :: T
      ! type(Tensor4) :: T2, piola4
      type(Tensor4s) :: piola4s, FF
      ! integer :: i,j,k,l,ii,jj,kk,ll

      ! piola4%abcd = 0.d0
      ! T2 = tensorstore(T)

      ! do i=1,3
      ! do j=1,3
      ! do k=1,3
      ! do l=1,3
      ! do ii=1,3
      ! do jj=1,3
      ! do kk=1,3
      ! do ll=1,3
      ! piola4%abcd(i,j,k,l) = piola4%abcd(i,j,k,l) +
!    ! *             F%ab(i,ii)*F%ab(j,jj)*F%ab(k,kk)*F%ab(l,ll)
!    ! *             *T2%abcd(ii,jj,kk,ll)
      ! end do
      ! end do
      ! end do
      ! end do
      ! end do
      ! end do
      ! end do
      ! end do
      ! piola4s = symstore(piola4)

      FF = symstore(F.cdya.F)
      piola4s = FF**T**transpose(FF)

   end function piola4s

end module ttb_piola
