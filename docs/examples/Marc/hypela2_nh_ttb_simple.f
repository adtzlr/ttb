      include 'ttb/ttb_library.f'

      subroutine hypela2(d,g,e,de,s,t,dt,ngens,m,nn,kcus,matus,ndi,
     2             nshear,disp,dispt,coord,ffn,frotn,strechn,eigvn,ffn1,
     3                   frotn1,strechn1,eigvn1,ncrd,itel,ndeg,ndm,
     4                   nnode,jtype,lclass,ifr,ifu)

      ! UMAT:           Nearly-Incompressible Neo-Hookean Material
      !                 Example for usage of Tensor Toolbox
      ! capability:     3D, Axisymmetric
      ! Formulation:    Total Lagrange
      ! Voigt Notation: Change commented Tensor Datatypes
      ! Andreas Dutzler, 2018-01-02, Graz University of Technology

      use Tensor
      implicit none

      integer :: ifr,ifu,itel,jtype,ncrd,ndeg,ndi,ndm,ngens,
     *           nn,nnode,nshear
      integer,      dimension(2)       :: m,matus,kcus,lclass
      real(kind=8), dimension(*)       :: e,de,t,dt,g,s
      real(kind=8), dimension(itel)    :: strechn,strechn1
      real(kind=8), dimension(ngens,*) :: d
      real(kind=8), dimension(ncrd,*)  :: coord
      real(kind=8), dimension(ndeg,*)  :: disp, dispt
      real(kind=8), dimension(itel,3)  :: ffn,ffn1,frotn,frotn1
      real(kind=8), dimension(itel,*)  :: eigvn,eigvn1

      type(Tensor2)  :: F1
      real(kind=8) :: J,kappa,C10

      ! to use voigt notation change to type Tensor2s, Tensor4s
      type(Tensor2) :: C1,invC1,S1,Eye
      type(Tensor4) :: C4

      ! material parameters
      C10 = 0.5
      kappa = 5.0

      Eye = identity2(Eye)
      F1 = ffn1(1:3,1:3) ! use slices (ffn1 is an assumed size array)
      J = det(F1)

      ! right cauchy-green deformation tensor and it's inverse
      C1 = transpose(F1)*F1
      invC1 = inv(C1) ! faster method: invC1 = inv(C1,J**2)

      ! pk2 stress
      S1 = 2.*C10*J**(-2./3.)*dev(C1)*invC1 + kappa*(J-1)*J*invC1

      ! material elasticity tensor
      C4 = 2.*C10 * J**(-2./3.) * 2./3. *
     *  ( tr(C1) * (invC1.cdya.invC1)
     *    - (Eye.dya.invC1) - (invC1.dya.Eye)
     *    + tr(C1)/3. * (invC1.dya.invC1) )
     *  + (kappa*(J-1)*J+kappa*J**2) * (invC1.dya.invC1)
     *  - 2.*kappa*(J-1)*J* (invC1.cdya.invC1)

      ! output as array
      s(1:ngens)         = asarray( voigt(S1), ngens )
      d(1:ngens,1:ngens) = asarray( voigt(C4), ngens, ngens )

      return
      end
