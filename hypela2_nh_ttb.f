      include 'ttb/ttb_library.f'

      subroutine hypela2(d,g,e,de,s,t,dt,ngens,m,nn,kcus,matus,ndi,
     2             nshear,disp,dispt,coord,ffn,frotn,strechn,eigvn,ffn1,
     3                   frotn1,strechn1,eigvn1,ncrd,itel,ndeg,ndm,
     4                   nnode,jtype,lclass,ifr,ifu)
     
      ! HYPELA2 Nearly-Incompressible Neo-Hookean Material
      ! Formulation: Total Lagrange, Normal and Herrmann Elements
      ! Example for usage of Tensor Toolbox
      !
      ! Switch to Voigt Notation:
      ! - change commented Tensor Datatypes
      ! - save C1 with symstore(...)
      !
      ! Andreas Dutzler
      ! 2017-11-27
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

      type(Tensor2) :: F1
      
      ! voigt notation: type Tensor2s, Tensor4s
      !type(Tensor2s) :: C1,S1,invC1,Eye
      !type(Tensor4s) :: C4, I4
      type(Tensor2) :: C1,S1,invC1,Eye
      type(Tensor4) :: C4, I4
      real(kind=8) :: J,p,dpdJ,kappa,C10
      
      integer ndim
      
      ! dimension
      ndim = ndi+nshear
      
      ! material parameters
      C10 = 0.5
      kappa = 500.0
      
      Eye = identity2(Eye)
      F1 = ffn1(1:3,1:3)
      J = det(F1)
      
      ! voigt notation
      !C1 = symstore(transpose(F1)*F1,1) 
      
      ! tensor notation
      C1 = transpose(F1)*F1 
      
      invC1 = inv(C1)
      
      ! u or u/p formulation
      if (ngens > ndim) then
       p = e(ngens)+de(ngens)
       dpdJ = 0.d0
      else
       p = kappa*(J-1)
       dpdJ = kappa
      end if
      
      ! pk2 stress
      S1 = 2.*C10 * J**(-2./3.) * dev(C1)*inv(C1) + p*J*invC1
      
      ! output as array
      s(1:ndim) = asarray( symstore(S1,1), ndim )
      
      ! material elasticity tensor
      if (lovl.eq.4) then ! stage 4: tangent
       I4 = identity4(invC1)
       C4 = 4.*C10*J**(-2./3.)*2./3. * (tr(C1)*I4
     *    -(Eye.dya.invC1)-(invC1.dya.Eye)
     *    +tr(C1)/3.*(invC1.dya.invC1))
     *    +(p*J+dpdJ*J**2)*(invC1.dya.invC1)
     *    -2.*p*J*I4
     
       ! output as array
       d(1:ndim,1:ndim) = asarray( symstore(C4), ndim, ndim )
      endif
     
      ! herrmann formulation
      if (ngens > ndim) then
       s(ngens) = (J-1) - p/kappa
       d(ngens,1:ndim) = asarray( J*symstore(invC1,1), ndim)
       d(1:ndim,ngens) = d(ngens,1:ndim)
       d(ngens,ngens) = -1./kappa
      endif
      
      return
      end