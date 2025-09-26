## Example: Neo-Hookean Material (in LS-DYNA)

The following example discusses the implementation of the standard Neo-Hookean material model to show the usage of the tensor toolbox in LS-DYNA. The material model describes hyperelasticity and is formulated in the spatial (eulerian) configuration for 3D and axisymmetric computations (@todo not yet adapted for 2D). Be aware that in LS-Dyna umat (stress and history update) and utan (tangent) are split up, as noted in the section "User-defined tangent routine "utan"".

## Kinematics
In LS-DYNA we first have to set the option "IHYPER=1" in the material card keyword (e.g. *MAT_USER_DEFINED_MATERIAL_MODELS) to be able to access the deformation gradient <a href="https://www.codecogs.com/eqnedit.php?latex=\boldsymbol{F}" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\boldsymbol{F}" title="\boldsymbol{F}" /></a> (see section "Example material card"). The latter is then stored on top of the defined number of history variables. So, in case we don't require any history variables for our material model (NHV=0), as for this hyperelastic model, the deformation gradient is stored in the initial "hsv" entries 1 to 9 columnwise. As a consquence, we can extract it via the function
```fortran
type(Tensor2) :: defoGrad_F
defoGrad_F  = defoGrad(hsv(1:9))
```
which takes the list entries 1 to 9 and stores them into the second order tensor `defoGrad_F`.

## Equations
The Cauchy stress tensor <a href="https://www.codecogs.com/eqnedit.php?latex=\boldsymbol{\sigma}" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\boldsymbol{\sigma}" title="\boldsymbol{\sigma}" /></a> for the Neo-Hookean material can be computed from

<a href="https://www.codecogs.com/eqnedit.php?latex=\boldsymbol{\sigma}&space;=&space;\frac{1}{J}&space;\cdot&space;\left&space;[&space;\mu&space;\cdot&space;\left&space;[&space;\boldsymbol{F}&space;\boldsymbol{F}^T&space;-&space;\boldsymbol{I}&space;\right&space;]&space;&plus;&space;\lambda&space;\ln(J)&space;\boldsymbol{I}&space;\right&space;]" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\boldsymbol{\sigma}&space;=&space;\frac{1}{J}&space;\cdot&space;\left&space;[&space;\mu&space;\cdot&space;\left&space;[&space;\boldsymbol{F}&space;\boldsymbol{F}^T&space;-&space;\boldsymbol{I}&space;\right&space;]&space;&plus;&space;\lambda&space;\ln(J)&space;\boldsymbol{I}&space;\right&space;]" title="\boldsymbol{\sigma} = \frac{1}{J} \cdot \left [ \mu \cdot \left [ \boldsymbol{F} \boldsymbol{F}^T - \boldsymbol{I} \right ] + \lambda \ln(J) \boldsymbol{I} \right ]" /></a>

The Eulerian tangent modulus is computed as

<a href="https://www.codecogs.com/eqnedit.php?latex=\boldsymbol{E}&space;=&space;\frac{1}{J}&space;\cdot&space;\left&space;[&space;\lambda&space;\boldsymbol{I}&space;\otimes&space;\boldsymbol{I}&space;&plus;&space;2&space;\left&space;[&space;\mu&space;-&space;\lambda&space;\ln&space;(J)&space;\right&space;]&space;\overset{4}{I}&space;\right&space;]" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\boldsymbol{E}&space;=&space;\frac{1}{J}&space;\cdot&space;\left&space;[&space;\lambda&space;\boldsymbol{I}&space;\otimes&space;\boldsymbol{I}&space;&plus;&space;2&space;\left&space;[&space;\mu&space;-&space;\lambda&space;\ln&space;(J)&space;\right&space;]&space;\overset{4}{I}&space;\right&space;]" title="\boldsymbol{E} = \frac{1}{J} \cdot \left [ \lambda \boldsymbol{I} \otimes \boldsymbol{I} + 2 \left [ \mu - \lambda \ln (J) \right ] \overset{4}{I} \right ]" /></a>

With
* Jacobian, determinant of the deformation gradient

<a href="https://www.codecogs.com/eqnedit.php?latex=J&space;=&space;\text{det}(\boldsymbol{F})" target="_blank"><img src="https://latex.codecogs.com/gif.latex?J&space;=&space;\text{det}(\boldsymbol{F})" title="J = \text{det}(\boldsymbol{F})" /></a>
* First and second Lame parameters 
<a href="https://www.codecogs.com/eqnedit.php?latex=\lambda" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\lambda" title="\lambda" /></a> and <a href="https://www.codecogs.com/eqnedit.php?latex=\mu" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\mu" title="\mu" /></a>
* Second order unit/identity tensor
<a href="https://www.codecogs.com/eqnedit.php?latex=\boldsymbol{I}" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\boldsymbol{I}" title="\boldsymbol{I}" /></a>
* Fourth order unit/identity tensor
<a href="https://www.codecogs.com/eqnedit.php?latex=\overset{4}{I}" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\overset{4}{I}" title="\overset{4}{I}" /></a>

## User-defined material routine "umat"
### The commented program
In LS-Dyna we can expand the existing file `dyn21umats.F`. At the beginning of the Fortran file include the tensor toolbox after defining the flag `NOR4`. The latter ensures that the r4 variants of implemented functions are skipped, which would else generate compiler errors in LS-Dyna (see https://github.com/adtzlr/ttb/issues/10).
```fortran
#define NOR4
#include  'ttb/ttb_library.F'
```
Then scroll down to an unused user-defined material, for instance umat43, reading
```fortran
      subroutine umat43 (cm,eps,sig,epsp,hsv,dt1,capa,etype,tt,
     1 temper,failel,crv,nnpcrv,cma,qmat,elsiz,idele,reject)
```
Firstly, we have to declare the usage of the tensor module and the LS-DYNA extension.
```fortran
c Use the tensor toolbox
      use Tensor
      use TensorXLSDYNA
```
Next, the standard LS-Dyna declarations follow and don't need to be altered.
```fortran
c Standard LS-Dyna declarations
      include 'nlqparm'
      include 'bk06.inc'
      include 'iounits.inc'
      real(kind=8), dimension(*) :: cm, eps, sig, hsv
      dimension crv(lq1,2,*),cma(*),qmat(3,3)
      logical failel,reject
      integer nnpcrv(*)
      character*5 etype
      INTEGER8 idele
```
Now we declare our variables.
```fortran
c declaration
      ! Deformation gradient (unsymmetric second order tensor)
       type(Tensor2) :: defoGrad_F
      ! Jacobian, determinant of the deformation gradient
       double precision :: det_F
      ! Cauchy stress tensor; unit tensor
       type(Tensor2) :: cauchyStress_sig, Eye
      ! material parameters
      double precision YoungsMod_E, Poisson_nu, lame_lambda, shearMod_mu
```
Extract the material parameters from the 'cm'-array
```fortran
      YoungsMod_E = cm(1)
      Poisson_nu =  cm(2)
```
Compute the Lame parameters lambda and mu (or G)
```fortran
      lame_lambda = YoungsMod_E * Poisson_nu
     &              / ( (1.+Poisson_nu)*(1.-2.*Poisson_nu) )
      shearMod_mu = .5 * YoungsMod_E / (1.+Poisson_nu)
```
Get the unit tensor via the tensor toolbox
```fortran
      Eye = identity2(Eye)
```
Extract the deformation gradient from the history 'hsv' and transform it into the unsymmetric second order tensor as described above via the function 'defoGrad(*)' from the module TensorXLSDYNA
```fortran
      defoGrad_F = defoGrad( hsv(1:9) )
```
Compute the Jacobian as the determinant of the deformation gradient   
```fortran   
      det_F = det(defoGrad_F)
```
Compute the Cauchy stress for the Neo-Hookean material
```fortran
      cauchyStress_sig = 1./det_F * (
     &      shearMod_mu * ( (defoGrad_F * transpose(defoGrad_F)) - Eye )
     &      + lame_lambda * log(det_F) * Eye )
```
Transform the stress tensor into the 'sig' array
```fortran
      sig(1:6) = asarray(voigt(cauchyStress_sig),6)
c
      return
      end
```

### The plain program
```fortran
      subroutine umat43 (cm,eps,sig,epsp,hsv,dt1,capa,etype,tt,
     1 temper,failel,crv,nnpcrv,cma,qmat,elsiz,idele,reject)
c
      use Tensor
      use TensorXLSDYNA
c
      include 'nlqparm'
      include 'bk06.inc'
      include 'iounits.inc'
      real(kind=8), dimension(*) :: cm, eps, sig, hsv
      dimension crv(lq1,2,*),cma(*),qmat(3,3)
      logical failel,reject
      integer nnpcrv(*)
      character*5 etype
      INTEGER8 idele
c
      type(Tensor2) :: defoGrad_F
      double precision :: det_F
      type(Tensor2) :: cauchyStress_sig, Eye
      double precision YoungsMod_E, Poisson_nu, lame_lambda, shearMod_mu
c
      YoungsMod_E = cm(1)
      Poisson_nu =  cm(2)
c
      lame_lambda = YoungsMod_E * Poisson_nu
     &              / ( (1.+Poisson_nu)*(1.-2.*Poisson_nu) )
      shearMod_mu = .5 * YoungsMod_E / (1.+Poisson_nu)
c
      Eye = identity2(Eye)
c
      defoGrad_F = defoGrad( hsv(1:9) )
c    
      det_F = det(defoGrad_F)
c
      cauchyStress_sig = 1./det_F * (
     &      shearMod_mu * ( (defoGrad_F * transpose(defoGrad_F)) - Eye )
     &      + lame_lambda * log(det_F) * Eye )
c
      sig(1:6) = asarray(voigt(cauchyStress_sig),6)
c
      return
      end
```

## User-defined tangent routine "utan"
### The commented program
In LS-Dyna the computation of the material (stress and history update) and the tangent are split up into two separate subroutines. The tangent is implemented in the file `dyn21utan.F` into the subroutines `utanXX`, where the material id `XX` has to correspond to the id of the `umatXX` subroutine it belongs to.
We have already included the necessary files in the `dyn21umats.F` file, so for the tangent we can directly scroll down to the subroutine `utan43`.
```fortran
      subroutine utan43(cm,eps,sig,epsp,hsv,dt1,unsym,capa,etype,tt,
     1 temper,es,crv,nnpcrv,failel,cma,qmat)
```
We again load the modules
```fortran
c Use the tensor toolbox
      use Tensor
      use TensorXLSDYNA
```
Use the standard LS-Dyna declarations
```fortran
c Standard LS-Dyna declarations
      include 'nlqparm'
      real(kind=8), dimension (*) :: cm, eps, sig, hsv
      dimension crv(lq1,2,*),cma(*)
      integer nnpcrv(*)
      dimension es(6,*),qmat(3,3)
      logical failel,unsym
      character*5 etype
```
Declare our variables now also containing the fourth order tensor `tangent_E` for our tangent modulus. 
```fortran
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
```
As in the umat subroutine:
```fortran
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
```
In order to finally compute the Eulerian tangent for the Neo-Hookean material
```fortran
      tangent_E = 1./det_F * (
     &       lame_lambda * (Eye.dya.Eye) ! Be aware of the required parentheses,
                                         ! Else error "An arithmetic or LOGICAL type is required in this context."
     &       + ( 2. * ( shearMod_mu - lame_lambda * log(det_F) )
     &              * identity4(Eye) )
     &       )
```
Eventually, we pack the fourth order tensor into the 6x6 matrix `es`

```fortran
      es(1:6,1:6) = asarray(voigt(tangent_E),6,6)
c      
      return
      end
```
and end the subroutine.

### The plain program
```fortran
      subroutine utan43(cm,eps,sig,epsp,hsv,dt1,unsym,capa,etype,tt,
     1 temper,es,crv,nnpcrv,failel,cma,qmat)
c
      use Tensor
      use TensorXLSDYNA
c
      include 'nlqparm'
      real(kind=8), dimension (*) :: cm, eps, sig, hsv
      dimension crv(lq1,2,*),cma(*)
      integer nnpcrv(*)
      dimension es(6,*),qmat(3,3)
      logical failel,unsym
      character*5 etype
c
       type(Tensor2) :: defoGrad_F
       double precision :: det_F
       type(Tensor2) :: Eye
       type(Tensor4) :: tangent_E
      double precision YoungsMod_E, Poisson_nu, lame_lambda, shearMod_mu
c
      YoungsMod_E = cm(1)
      Poisson_nu = cm(2)
c
      lame_lambda = YoungsMod_E * Poisson_nu
     &              / ((1.+Poisson_nu)*(1.-2.*Poisson_nu))
      shearMod_mu = .5*YoungsMod_E / (1.+Poisson_nu)
c
      Eye = identity2(Eye)
c
      defoGrad_F = defoGrad( hsv(1:9) )
c     
      det_F = det(defoGrad_F)
c
      tangent_E = 1./det_F * (
     &       lame_lambda * (Eye.dya.Eye)
     &       + ( 2. * ( shearMod_mu - lame_lambda * log(det_F) )
     &              * identity4(Eye) )
     &       )
c
      es(1:6,1:6) = asarray(voigt(tangent_E),6,6)
c      
      return
      end
```

## Example material card
The material id in the option "MT" must equal the id in `umatXX` and `utanXX`. The value of "NHV" sets the number of used history variables, here none are used in the material model. The option "IHYPER=1" stores the deformation gradient in the history "hsv" on top of the defined "NHV". The paramters "P1" and "P2" contain the Young's modulus in "cm(1)" and the Poisson ratio in "cm(2)", respectively.

<img src="https://github.com/jfriedlein/usrmat_LS-Dyna_Fortran/blob/master/Neo-Hookean%20-%20Tensor/material-card%20example.png" width="500">