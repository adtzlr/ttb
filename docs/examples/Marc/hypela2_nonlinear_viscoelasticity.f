      include 'ttb/ttb_library.f'

      subroutine hypela2(d,g,e,de,s,t,dt,ngens,m,nn,kcus,matus,ndi,
     2             nshear,disp,dispt,coord,ffn,frotn,strechn,eigvn,ffn1,
     3                   frotn1,strechn1,eigvn1,ncrd,itel,ndeg,ndm,
     4                   nnode,jtype,lclass,ifr,ifu)

      ! HYPELA2 Nonlinear Viscoelasticity with
      !         Neo-Hookean Hyperelasticity
      ! ----------------------------------------------------------------
      ! Source: Shutov et.al. (2013): An explicit solution for
      !         implicit time stepping in multiplicative
      !         finite strain viscoelasticity.
      !         DOI: http://dx.doi.org/10.1016/j.cma.2013.07.004
      !         --> Lagrangian formulation, EBMSC-method (eq.41f)
      !
      ! Formulation: Total Lagrange, Large Strain
      !             (with option for Updated Lagrange with Push Forward
      !              and Jaumann-like Tangent Correction included)
      !
      ! ----------------------------------------------------------------
      ! Andreas Dutzler, Graz University of Technology
      ! 2018-04-05

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

      include 'concom'
      include 'creeps'

      ! begin user code
      type(Tensor2)  :: F1
      type(Tensor2s) :: C1,invC1,C0_i,invC1_i,S1,S1_hat,S1_bar,Eye,
     *                  Phi,Phi_hat,invPhi
      type(Tensor4s) :: C4,C4_hat,C4_bar,I4,P4,Eye4
      real(kind=8)   :: J,J_th,C10,mu,eta,kappa,tr_SC,
     *                  p,dpdJ,detPhi,dtime

      ! material parameters
      C10 = 0.5
      mu = 2.0
      eta = 10.0
      kappa = 50.0

      ! time increment
      dtime = timinc

      ! deformation gradient
      Eye = identity2(Eye)
      F1 = Eye
      F1%ab(1:itel,1:3) = ffn1(1:itel,1:3)

      ! volumetric ratio
      J = det(F1)

      ! hydrostatic stress and derivative
      p = kappa*(J-1)
      dpdJ = kappa

      ! right cauchy-green deformation tensor and inverse
      C1 = transpose(F1)*F1
      invC1 = inv(C1,J**2)

      ! PK2-stress elastic ground network
      S1_hat = 2.*C10*Eye
      C4_hat = 0.0

      ! inelastic deformation at beginning of the inc.
      C0_i = t(2:7)
      if (t(2) == 0.0) then
       ! if start of analysis is detected
       ! --> no inelastic deformation
       C0_i = Eye
      end if

      ! inelastic part of rCG (= Phi_hat)
      Phi = C0_i + mu*dtime/eta * J**(-2./3.)*C1
      Phi_hat = unimodular(Phi)
      invC1_i = inv(Phi_hat,1.d0)

      ! PK2-stress viscous overstress
      S1_hat = S1_hat + mu*(invC1_i)
      Eye4 = Eye.cdya.Eye
      detPhi = det(Phi)
      invPhi = inv(Phi,detPhi)
      C4_hat = C4_hat + (mu*(invC1_i.cdya.invC1_i))**
     *         (detPhi**(-1./3.) * 2.*mu*dtime/eta*
     *         (Eye4 - 1./3.*(Phi.dya.invPhi)))

      S1_bar = J**(-2./3.) * S1_hat
      C4_bar = J**(-4./3.) * C4_hat

      ! distortional + hydrostatic component of PK2-stress
      tr_SC = S1_bar**C1
      S1 = (S1_bar - 1./3.*tr_SC*invC1) + p*J*invC1

      ! material elasticity tensor
      I4 = invC1.cdya.invC1
      P4 = (Eye.cdya.Eye) - 1./3.*(invC1.dya.C1)
      C4 = P4**C4_bar**transpose(P4)
     *    + 2./3. * (tr_SC*I4
     *    -(S1_bar.dya.invC1)-(invC1.dya.S1_bar)
     *    +tr_SC/3.*(invC1.dya.invC1))
     *    +(p*J+dpdJ*J**2)*(invC1.dya.invC1)
     *    -2.*p*J*I4

      ! (lovl==6) --> solution converged, save state variables
      if (lovl.eq.6) then
       t(2:7) = asarray( asvoigt(Phi_hat), 6)
      end if

      ! updated lagrange
      if (iupdat.eq.1) then
       ! cauchy stress
       S1 = piola(F1,S1)/J
       ! tangent matrix (jaumann-like co-rotated)
       C4 = piola(F1,C4)/J
     *      + (S1.cdya.Eye) + (Eye.cdya.S1)
      endif

      ! output as array
      s(1:ngens)         = asarray( asvoigt(S1), ngens )
      d(1:ngens,1:ngens) = asarray( asvoigt(C4), ngens,ngens )

      return
      end
