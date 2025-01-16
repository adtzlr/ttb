      include 'ttb/ttb_library.f'

      subroutine hypela2(d,g,e,de,s,t,dt,ngens,m,nn,kcus,matus,ndi,
     2             nshear,disp,dispt,coord,ffn,frotn,strechn,eigvn,ffn1,
     3                   frotn1,strechn1,eigvn1,ncrd,itel,ndeg,ndm,
     4                   nnode,jtype,lclass,ifr,ifu)

      ! HYPELA2 St. Venant - Kirchhoff Material
      ! Formulation: Total Lagrange, Large Strain
      !              (Updated Lagrange with Push Forward
      !               and Jaumann Correction)
      !
      ! Andreas Dutzler, Graz University of Technology
      ! 2018-02-11

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

      type(Tensor2)  :: F1

      type(Tensor2s) :: E1,S1,Eye
      type(Tensor4s) :: C4

      real(kind=8) :: J,young,nu,lambda,mu

      ! material parameters
      young = 210000.0
      nu = 0.3

      ! lame parameter
      mu = young / ( 2.*(1.+nu) )
      lambda = nu*young / ((1.+nu)*(1.-2.*nu))

      ! large strain formulation
      Eye = Eye**0
      F1 = Eye
      F1%ab(1:itel,1:3) = ffn1(1:itel,1:3)
      E1 = 0.5*(transpose(F1)*F1-Eye)

      ! material elasticity tensor
      C4 = lambda*(Eye.dya.Eye) + 2.*mu*(Eye.cdya.Eye)

      ! pk2 stress
      S1 = lambda*tr(E1)*Eye + 2.*mu*E1

      if (iupdat.eq.1) then ! updated lagrange
       J = det(F1)
       ! cauchy stress
       S1 = piola(F1,S1)/J
       ! tangent matrix (jaumann)
       C4 = piola(F1,C4)/J
     *      + (S1.cdya.Eye) + (Eye.cdya.S1)
      endif

      ! output as array
      s(1:ngens)         = asarray( asvoigt(S1), ngens )
      d(1:ngens,1:ngens) = asarray( asvoigt(C4), ngens,ngens )

      return
      end
