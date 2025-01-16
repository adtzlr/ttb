      include 'ttb/ttb_library.f'

      subroutine hypela2(d,g,e,de,s,t,dt,ngens,m,nn,kcus,matus,ndi,
     2             nshear,disp,dispt,coord,ffn,frotn,strechn,eigvn,ffn1,
     3                   frotn1,strechn1,eigvn1,ncrd,itel,ndeg,ndm,
     4                   nnode,jtype,lclass,ifr,ifu)

      ! HYPELA2 Nearly-Incompressible Neo-Hookean Material
      ! Formulation: Total Lagrange, Displacement and Herrmann Elements
      ! Updated Lagrange: Push Forward and transform to Jaumann Tangent
      ! Example for usage of Tensor Toolbox
      !
      ! Switch to Voigt Notation:
      ! - change commented Tensor Datatypes
      !
      ! Andreas Dutzler
      ! 2017-12-21
      ! Graz University of Technology

      use Tensor
      implicit none

      real*8 coord, d, de, disp, dispt, dt, e, eigvn, eigvn1, ffn, ffn1
      real*8 frotn, frotn1, g
      integer ifr, ifu, itel, jtype, kcus, lclass, matus, m, ncrd, ndeg
      integer ndi, ndm, ngens, nn, nnode, nshear
      real*8 s, strechn, strechn1, t

      dimension e(*),de(*),t(*),dt(*),g(*),d(ngens,*),s(*)
      dimension m(2),coord(ncrd,*),disp(ndeg,*),matus(2),
     *          dispt(ndeg,*),ffn(itel,3),frotn(itel,3),
     *          strechn(itel),eigvn(itel,*),ffn1(itel,3),
     *          frotn1(itel,3),strechn1(itel),eigvn1(itel,*),
     *          kcus(2),lclass(2)
      include 'concom'
      include 'creeps'

      type(Tensor2)  :: F1
      type(Tensor2s) :: E1

      ! voigt notation: change to type Tensor2s, Tensor4s
      type(Tensor2s) :: C1,S1,invC1,Eye
      type(Tensor4s) :: C4, I4, SdyaI

      real(kind=8) :: J,J_th,p,dpdJ,kappa,C10,alpha

      integer ndim

      ! dimension
      ndim = ndi+nshear

      ! material parameters
      C10 = 0.5
      kappa = 500.0
      alpha = 1.5d-4

      Eye = identity2(Eye)
      F1 = tensorstore(Eye)
      F1%ab(1:itel,1:3) = ffn1(1:itel,1:3)
      J = det(F1)
      J_th = (1+alpha*(t(1)+dt(1)))**3

      C1 = transpose(F1)*F1
      J = det(C1)**(1./2.)
      invC1 = inv(C1)

      ! u or u/p formulation
      if (ngens > ndim) then
       p = e(ngens)+de(ngens)
       dpdJ = 0.d0
      else
       p = kappa*(J/J_th-1)
       dpdJ = kappa/J_th
      end if

      ! pk2 stress
      S1 = 2.*C10 * J**(-2./3.) * dev(C1)*invC1 + p*J*invC1

      if (iupdat.eq.1) then
       S1 = piola(F1,S1)/J ! S1 = 1/J * F1*S1*transpose(F1)
      endif

      ! output as array
      s(1:ndim) = asarray( voigt(S1), ndim )

      ! material elasticity tensor
      I4 = invC1.cdya.invC1
      C4 = 2.*C10*J**(-2./3.)*2./3. * (tr(C1)*I4
     *    -(Eye.dya.invC1)-(invC1.dya.Eye)
     *    +tr(C1)/3.*(invC1.dya.invC1))
     *    +(p*J+dpdJ*J**2)*(invC1.dya.invC1)
     *    -2.*p*J*I4
      if (iupdat.eq.1) then
       C4 = piola(F1,C4)/detF1 + (S1.cdya.Eye)+(Eye.cdya.S1)
      endif

      ! output as array
      d(1:ndim,1:ndim) = asarray( voigt(C4), ndim, ndim )

      ! herrmann formulation
      if (iupdat.eq.1) then
        invC1 = Eye/J
      endif
      if (ngens > ndim) then
       s(ngens) = (J-J_th) - p*J_th**2/kappa
       d(ngens,1:ndim) = asarray( J*voigt(invC1), ndim)
       d(1:ndim,ngens) = d(ngens,1:ndim)
       d(ngens,ngens) = -J_th**2/kappa
       g(1:ndim) = 0.d0
       g(ngens) = -(1+2*p/kappa*J_th) * 3.*alpha*J_th**(2./3.)*dt(1)
      else
       g(1:ndim) = -kappa*J/J_th**2 * 3.*alpha*J_th**(2./3.)
     *              * J * asarray(voigt(invC1), ndim)*dt(1)
      endif

      return
      end
