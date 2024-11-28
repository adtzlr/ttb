      subroutine utan47(cm,eps,sig,epsp,hsv,dt1,unsym,capa,etype,tt,
     1 temper,es,crv,nnpcrv,failel,cma,qmat)
c
c Use the tensor toolbox
      use Tensor
      use TensorXLSDYNA
c Standard LS-Dyna declarations
      include 'nlqparm'
      real(kind=8), dimension (*) :: cm, eps, sig, hsv
      dimension crv(lq1,2,*),cma(*)
      integer nnpcrv(*)
      dimension es(6,*),qmat(3,3)
      logical failel,unsym
      character*5 etype
c declaration
      ! Deformation gradient (unsymmetric second order tensor)
       type(Tensor2) :: defoGrad_F
      ! Jacobian, determinant of the deformation gradient
       double precision :: det_F
      ! unit tensor
       type(Tensor2) :: Eye
      ! Fourth order Eulerian tangent modulus
       type(Tensor4) :: tangent_E
      ! material parameters
      double precision YoungsMod_E, Poisson_nu, lame_lambda, shearMod_mu
c Extract the material parameters from the 'cm'-array
      YoungsMod_E = cm(1)
      Poisson_nu = cm(2)
c Compute the Lame parameters lambda and mu (or G)
      lame_lambda = YoungsMod_E * Poisson_nu
     &              / ((1.+Poisson_nu)*(1.-2.*Poisson_nu))
      shearMod_mu = .5*YoungsMod_E / (1.+Poisson_nu)
c Get the unit tensor via the tensor toolbox
      Eye = identity2(Eye)
c Extract the deformation gradient from the history 'hsv'
      defoGrad_F = defoGrad( hsv(1:9) )
c Compute the Jacobian as the determinant of the deformation gradient      
      det_F = det(defoGrad_F)
c Compute the Eulerian tangent for the Neo-Hookean material
      tangent_E = 1./det_F * (
     &       lame_lambda * (Eye.dya.Eye) ! Be aware of the required parentheses,
                                         ! Else error "An arithmetic or LOGICAL type is required in this context."
     &       + ( 2. * ( shearMod_mu - lame_lambda * log(det_F) )
     &              * identity4(Eye) )
     &       )
c Transform the fourth order tensor into the 'es' matrix
      es(1:6,1:6) = asarray(voigt(tangent_E),6,6)
c      
      return
      end