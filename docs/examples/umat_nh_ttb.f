      include 'ttb/ttb_library.f'

      SUBROUTINE UMAT(STRESS,STATEV,DDSDDE,SSE,SPD,SCD,
     1 RPL,DDSDDT,DRPLDE,DRPLDT,
     2 STRAN,DSTRAN,TIME,DTIME,TEMP,DTEMP,PREDEF,DPRED,CMNAME,
     3 NDI,NSHR,NTENS,NSTATV,PROPS,NPROPS,COORDS,DROT,PNEWDT,
     4 CELENT,DFGRD0,DFGRD1,NOEL,NPT,LAYER,KSPT,JSTEP,KINC)
     
      ! ABAQUS UMAT:    Nearly-Incompressible Neo-Hookean Material
      !                 Example for usage of Tensor Toolbox
      ! capability:     3D analysis
      ! Formulation:    Total Lagrange with push forward for Abaqus
      ! Jamal Bhatti, 2023-09-23, Leibniz University Hannover
      
      
      
      use Tensor
      !implicit none
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
      real(kind=8)  :: J,kappa,C10,D1,dUdI1bar,dUdJ,ddUdJdJ,p,ptilde

      ! also possible as types Tensor2s and Tensor4s
      type(Tensor2) :: C1,invC1,S1,Eye,Cbar,Sbar,Siso
      type(Tensor4) :: C4,P4tilde,C4iso,C4vol
      
      ! material parameters
      C10 = PROPS(2)
      D1 = PROPS(1)
      kappa = TWO/D1
      
      Eye = identity2(Eye)
      F1 = dfgrd1(1:3,1:3)
      J = det(F1)
      
      ! right cauchy-green deformation tensor and it's inverse
      C1 = transpose(F1)*F1
      invC1 = inv(C1)

      dUdJ = kappa*(J-1)
      ddUdJdJ = kappa

      dUdI1bar = C10

      Cbar = J**(-2./3.)*C1
      Sbar = TWO*dUdI1bar*Eye
      
      p = dUdJ
      ptilde = p + J * ddUdJdJ
      P4 = identity4(Eye)-1./3.*(invC1.dya.C1)
      Siso = J**(-2./3.)*(P4**Sbar)
      
      ! push forward of pk2 stress to cauchy stress
      S1 = piola(F1,J*p*invC1 + Siso)/J
      
      P4tilde = identity4(invC1) - 1./3.*(invC1.dya.invC1)
      
      C4iso = 2./3.*tr(Sbar*Cbar)*P4tilde - 2./3.*(
     *        (invC1.dya.Siso) + (Siso.dya.invC1))
      C4vol = (J*ptilde) * ((invC1.dya.invC1))-(2.*J*p)
     *        *(identity4(invC1))
      
      ! push forward to jaumann tangent of cauchy stress for abaqus
      C4 = piola(F1,C4iso+C4vol)/J + (S1.cdya.Eye)+(Eye.cdya.S1)
      
      ! output as array
      STRESS(1:ntens)         = asabqarray(voigt(S1),ntens)
      DDSDDE(1:ntens,1:ntens) = asabqarray(voigt(C4),ntens,ntens)
      
      return
      end