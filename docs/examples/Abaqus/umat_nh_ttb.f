      include 'ttb/ttb_library.f'

      SUBROUTINE UMAT(STRESS,STATEV,DDSDDE,SSE,SPD,SCD,
     1 RPL,DDSDDT,DRPLDE,DRPLDT,
     2 STRAN,DSTRAN,TIME,DTIME,TEMP,DTEMP,PREDEF,DPRED,CMNAME,
     3 NDI,NSHR,NTENS,NSTATV,PROPS,NPROPS,COORDS,DROT,PNEWDT,
     4 CELENT,DFGRD0,DFGRD1,NOEL,NPT,LAYER,KSPT,JSTEP,KINC)

      ! ABAQUS UMAT:    Easy-to-extend Nearly-Incompressible Neo-Hookean
!                       Material Formulation
      !                 Example for usage of Tensor Toolbox
      ! capability:     3D, Axisymmetric
      ! Formulation:    Total Lagrange with push forward for Abaqus
      ! Reference:      Holzapfel, G. (2001). NONLINEAR SOLID MECHANICS.
      !                 A Continuum Approach for Engineering.
      !
      ! Jamal Bhatti, 2023-09-23, Leibniz University Hannover

      use Tensor

      ! `implicit none` is not supported if 'ABA_PARAM.INC' is included.
      ! declare all double-variables which start with `i,j,k,l,m,n`
      ! - otherwise they will be integers

      ! implicit none
      INCLUDE 'ABA_PARAM.INC'

      CHARACTER*80 CMNAME
      DIMENSION STRESS(NTENS),STATEV(NSTATV),
     1 DDSDDE(NTENS,NTENS),DDSDDT(NTENS),DRPLDE(NTENS),
     2 STRAN(NTENS),DSTRAN(NTENS),TIME(2),PREDEF(1),DPRED(1),
     3 PROPS(NPROPS),COORDS(3),DROT(3,3),DFGRD0(3,3),DFGRD1(3,3),
     4 JSTEP(4)

      PARAMETER(ZERO=0.D0, ONE=1.D0, TWO=2.D0, THREE=3.D0, FOUR=4.D0)

      type(Tensor2) :: F1
      type(Tensor4) :: P4
      real(kind=8)  :: J,kappa,C10,D1,dUdI1bar,dUdI2bar,dUdJ,ddUdJdJ
      real(kind=8)  :: ddUdI1bardI1bar,ddUdI2bardI2bar,ddUdI1bardI2bar
      real(kind=8)  :: p,ptilde,gama1bar,gama2bar,I1bar
      real(kind=8)  :: delta1bar,delta2bar,delta3bar,delta4bar

      ! also possible as types Tensor2s and Tensor4s
      type(Tensor2) :: C1,invC1,S1,Eye,Cbar,Sbar,Siso
      type(Tensor4) :: C4,C4bar,P4tilde,C4iso,C4vol

      ! material parameters
      C10 = PROPS(2)
      D1 = PROPS(1)
      kappa = TWO/D1

      Eye = identity2(Eye)
      F1 = dfgrd1(1:3,1:3)
      J = det(F1)

      ! right cauchy-green deformation tensor and its inverse
      C1 = transpose(F1) * F1
      invC1 = inv(C1)

      dUdJ = kappa * (J - 1)
      ddUdJdJ = kappa

      dUdI1bar = C10
      dUdI2bar = ZERO

      ! double derivatives
      ddUdI1bardI1bar = ZERO
      ddUdI1bardI2bar = ZERO
      ddUdI2bardI2bar = ZERO

      Cbar = J**(-2./3.) * C1
      I1bar = tr(Cbar)
      gama1bar = TWO * (dUdI1bar + I1bar * dUdI2bar)
      gama2bar = -TWO * dUdI2bar
      Sbar = gama1bar * Eye + gama2bar * Cbar

      p = dUdJ
      ptilde = p + J * ddUdJdJ
      P4 = identity4(Eye) - 1./3. * (invC1.dya.C1)
      Siso = J**(-2./3.) * (P4**Sbar)

      ! push forward of pk2 stress to cauchy stress
      S1 = piola(F1, J * p * invC1 + Siso) / J

      ! coefficients for the elasticity tensor
      delta1bar = FOUR * (ddUdI1bardI1bar +
     *            TWO * I1bar * ddUdI1bardI2bar + dUdI2bar +
     *            I1bar**2 * ddUdI2bardI2bar)
      delta2bar = -FOUR * (ddUdI1bardI2bar + I1bar * ddUdI2bardI2bar)
      delta3bar = FOUR * ddUdI2bardI2bar
      delta4bar = -FOUR * dUdI2bar

      C4bar = J**(-4./3.) * (delta1bar * (Eye.dya.Eye)
     *      + delta2bar * ((Eye.dya.Cbar) + (Cbar.dya.Eye))
     *      + delta3bar * (Cbar.dya.Cbar)
     *      + delta4bar * identity4(Eye))

      P4tilde = identity4(invC1) - 1./3. * (invC1.dya.invC1)

      C4iso = P4**C4bar**transpose(P4)
     *      + 2./3. * tr(Sbar*Cbar) * P4tilde
     *      - 2./3. * ((invC1.dya.Siso) + (Siso.dya.invC1))
      C4vol = (J * ptilde) * ((invC1.dya.invC1)) - (2. * J * p)
     *      * (identity4(invC1))

      ! push forward to jaumann tangent of cauchy stress for abaqus
      C4 = piola(F1, C4iso + C4vol) / J + (S1.cdya.Eye) + (Eye.cdya.S1)

      ! output as array
      STRESS(1:ntens)         = asabqarray(voigt(S1),ntens)
      DDSDDE(1:ntens,1:ntens) = asabqarray(voigt(C4),ntens,ntens)

      return
      end
