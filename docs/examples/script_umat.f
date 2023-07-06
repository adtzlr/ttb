       include 'ttb/ttb_library.f'

       program script_tensortoolbox

       ! Example program for ttb-usage
       ! ttb is only active inside user subroutine

       implicit none

       real(kind=8), dimension(3,3) :: F, E, Eye

       real(kind=8), dimension(3,3) :: Siso
       real(kind=8), dimension(3,3,3,3) :: C4iso

       ! Deformation Gradient
       F = 0.0
       F(1,1) = 1.1
       F(2,2) = 1.0
       F(3,3) = 1.0
       F(1,2) = 0.1
       F(1,3) = 0.0

       Eye = 0.0
       Eye(1,1) = 1.0
       Eye(2,2) = 1.0
       Eye(3,3) = 1.0

       ! Green-Lagrange Strain
       E = 0.5*(matmul(transpose(F),F) - Eye)

       ! User Material Subroutine
       call umat(Siso,C4iso,F,E)

       ! Outputs
       print *, ''
       print *, '2nd Piola Kirchhoff Stress Tensor'
       write (*,993) Siso
       print *, ''
       print *, 'Material Elasticity Tensor'
       write (*,999) C4iso
       print *, ''

993    format('| ',f8.2,' ',f8.2,' ',f8.2,' |')
996    format('| ',f8.2,' ',f8.2,' ',f8.2,' ',
     *             f8.2,' ',f8.2,' ',f8.2,' |')
999    format('| ',f8.2,' ',f8.2,' ',f8.2,' ',
     *             f8.2,' ',f8.2,' ',f8.2,' ',
     *             f8.2,' ',f8.2,' ',f8.2,' |')

       end program script_tensortoolbox

       subroutine umat(Siso_arr,C4iso_arr,F_arr,E_arr)
       ! A very basic Example of a User Material Subroutine
       ! Isochoric part of nearly-incompressible Neo-Hookean material

       use Tensor

       implicit none

       real(kind=8) :: J

       real(kind=8), dimension(3,3), intent(in) :: F_arr, E_arr
       real(kind=8), dimension(3,3), intent(inout) :: Siso_arr
       real(kind=8), dimension(3,3,3,3), intent(inout) :: C4iso_arr

       type(Tensor2) :: F, E
       type(Tensor2) :: Siso
       type(Tensor4) :: C4iso

       type(Tensor2) :: Shat, Eye, C, invC
       type(Tensor4) :: C4hat, P4

       F = F_arr
       E = E_arr

       J = det(F)
       Eye = identity2(Eye)

       C = transpose(F)*F
       invC = inv(C)

       Shat = J**(-2./3.)*Eye

       ! Isochoric part of 2nd Piola Kirchhoff stress tensor
       Siso = dev(Shat*C)*invC

       ! Deviatoric projection tensor
       P4 = identity4(Eye)-1./3.*(invC.dya.C)
       C4hat = J**(-4./3.)*0.d0

       ! Isochoric part of Material Elasticity tensor
       C4iso = P4**C4hat**transpose(P4)
     *      + 2./3.*tr(Shat*C)*identity4(invC)
     *      - 2./3.*((Shat.dya.invC)+(invC.dya.Shat))
     *      + 2./9.*tr(Shat*C)*(invC.dya.invC)

       ! Ouput Tensor as Array with given dimensions
       Siso_arr(1:3,1:3) = Siso%ab(1:3,1:3)
       C4iso_arr(1:3,1:3,1:3,1:3) = C4iso%abcd(1:3,1:3,1:3,1:3)

       end
