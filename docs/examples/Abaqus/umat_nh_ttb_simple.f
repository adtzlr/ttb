      include 'ttb/ttb_library.f'

      SUBROUTINE UMAT(STRESS,STATEV,DDSDDE,SSE,SPD,SCD,
     1 RPL,DDSDDT,DRPLDE,DRPLDT,
     2 STRAN,DSTRAN,TIME,DTIME,TEMP,DTEMP,PREDEF,DPRED,CMNAME,
     3 NDI,NSHR,NTENS,NSTATV,PROPS,NPROPS,COORDS,DROT,PNEWDT,
     4 CELENT,DFGRD0,DFGRD1,NOEL,NPT,LAYER,KSPT,JSTEP,KINC)

      ! ABAQUS UMAT:    Nearly-Incompressible Neo-Hookean Material
      !                 Example for usage of Tensor Toolbox
      ! capability:     3D, Axisymmetric
      ! Formulation:    Total Lagrange with push forward for Abaqus
      ! Andreas Dutzler, 2018-07-22, Graz University of Technology

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

      type(Tensor2) :: F1
      real(kind=8)  :: J,kappa,C10

      type(Tensor2s) :: C1,invC1,S1,Eye
      type(Tensor4s) :: C4

      ! material parameters
      C10 = 0.5
      kappa = 5.0

      Eye = identity2(Eye)
      F1 = dfgrd1(1:3,1:3)
      J = det(F1)

      ! right cauchy-green deformation tensor and its inverse
      C1 = transpose(F1)*F1
      invC1 = inv(C1)

      ! pk2 stress
      S1 = 2.*C10*J**(-2./3.)*dev(C1)*invC1 + kappa*(J-1)*J*invC1

      ! push forward to cauchy stress
      S1 = piola(F1,S1)/J

      ! material elasticity tensor
      C4 = 2.*C10 * J**(-2./3.) * 2./3. *
     *  ( tr(C1) * (invC1.cdya.invC1)
     *    - (Eye.dya.invC1) - (invC1.dya.Eye)
     *    + tr(C1)/3. * (invC1.dya.invC1) )
     *  + (kappa*(J-1)*J+kappa*J**2) * (invC1.dya.invC1)
     *  - 2.*kappa*(J-1)*J* (invC1.cdya.invC1)

      ! push forward to jaumann tangent of cauchy stress for abaqus
      C4 = piola(F1,C4)/J + (S1.cdya.Eye)+(Eye.cdya.S1)

      ! output as array
      STRESS(1:ntens)         = asabqarray(voigt(S1),ntens)
      DDSDDE(1:ntens,1:ntens) = asabqarray(voigt(C4),ntens,ntens)

      return
      end
