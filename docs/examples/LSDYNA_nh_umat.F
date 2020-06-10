      subroutine umat47 (cm,eps,sig,epsp,hsv,dt1,capa,etype,tt,
     1 temper,failel,crv,nnpcrv,cma,qmat,elsiz,idele,reject)
c
c Use the tensor toolbox
      use Tensor
      use TensorXLSDYNA
c Standard LS-Dyna declarations (added some explicit data types)
      include 'nlqparm'
      include 'bk06.inc'
      include 'iounits.inc'
      real(kind=8), dimension(*) :: cm, eps, sig, hsv
      dimension crv(lq1,2,*),cma(*),qmat(3,3)
      logical failel,reject
      integer nnpcrv(*)
      character*5 etype
      INTEGER8 idele
c declaration
      ! Deformation gradient (unsymmetric second order tensor)
       type(Tensor2) :: defoGrad_F
      ! Jacobian, determinant of the deformation gradient
       double precision :: det_F
      ! Cauchy stress tensor; unit tensor
       type(Tensor2) :: cauchyStress_sig, Eye
      ! material parameters
      double precision YoungsMod_E, Poisson_nu, lame_lambda, shearMod_mu
c Extract the material parameters from the 'cm'-array
      YoungsMod_E = cm(1)
      Poisson_nu =  cm(2)
c Compute the Lame parameters lambda and mu (or G)
      lame_lambda = YoungsMod_E * Poisson_nu
     &              / ( (1.+Poisson_nu)*(1.-2.*Poisson_nu) )
      shearMod_mu = .5 * YoungsMod_E / (1.+Poisson_nu)
c Get the unit tensor via the tensor toolbox
      Eye = identity2(Eye)
c Extract the deformation gradient from the history 'hsv'
c and transform it into the unsymmetric second order tensor
c 'defoGrad_F' via the function 'defoGrad(*)' from the module TensorXLSDYNA
      defoGrad_F = defoGrad( hsv(1:9) )
c Compute the Jacobian as the determinant of the deformation gradient      
      det_F = det(defoGrad_F)
c Compute the Cauchy stress for the Neo-Hookean material
      cauchyStress_sig = 1./det_F * (
     &      shearMod_mu * ( (defoGrad_F * transpose(defoGrad_F)) - Eye )
     &      + lame_lambda * log(det_F) * Eye )
c Transform the stress tensor into the 'sig' array
      sig(1:6) = asarray(voigt(cauchyStress_sig),6)
c
      return
      end