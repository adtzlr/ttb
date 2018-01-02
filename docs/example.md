## Examples

This is a very basic example on how to implement a nearly-incompressible version of the Neo-Hookean material model in a commercial FEM package (HYPELA2 for MSC.Marc).

The helmholtz free energy per unit reference volume is additively split into an isochoric and volumetric contribution. The first one is assumed to be proportional to the first invariant of the isochoric right Cauchy-Green deformation tensor whereas the volumetric part is only a function of the volumetric ratio.

<a href="https://www.codecogs.com/eqnedit.php?latex=\psi(\mathbf{C})&space;=&space;\psi(\mathbf{\hat&space;C})&space;&plus;&space;U(J)" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\psi(\mathbf{C})&space;=&space;\psi(\mathbf{\hat&space;C})&space;&plus;&space;U(J)" title="\psi(\mathbf{C}) = \psi(\mathbf{\hat C}) + U(J)" /></a>

<a href="https://www.codecogs.com/eqnedit.php?latex=\psi(\mathbf{C})&space;=&space;\text{C}_{10}&space;(\text{I}_\mathbf{\hat&space;C}-3)&space;&plus;&space;\frac{\kappa}{2}&space;(J-1)^2" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\psi(\mathbf{C})&space;=&space;\text{C}_{10}&space;(\text{I}_\mathbf{\hat&space;C}-3)&space;&plus;&space;\frac{\kappa}{2}&space;(J-1)^2" title="\psi(\mathbf{C}) = \text{C}_{10} (\text{I}_\mathbf{\hat C}-3) + \frac{\kappa}{2} (J-1)^2" /></a>

We get the second Piola-Kirchhoff stress with the derivative of the helmholtz free energy per unit reference volume with respect to one half of the right Cauchy-Green deformation tensor:

<a href="https://www.codecogs.com/eqnedit.php?latex=\mathbf{S}&space;=&space;\frac{\partial&space;\psi(\mathbf{C})}{\partial&space;\frac{1}{2}\mathbf{C}}" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\mathbf{S}&space;=&space;\frac{\partial&space;\psi(\mathbf{C})}{\partial&space;\frac{1}{2}\mathbf{C}}" title="\mathbf{S} = \frac{\partial \psi(\mathbf{C})}{\partial \frac{1}{2}\mathbf{C}}" /></a>

<a href="https://www.codecogs.com/eqnedit.php?latex=\mathbf{S}&space;=&space;2\text{C}_{10}&space;\&space;\text{dev}(\hat{\mathbf{C}})&space;\mathbf{C}^{-1}&space;&plus;&space;\kappa&space;(J-1)&space;J&space;\mathbf{C}^{-1}" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\mathbf{S}&space;=&space;2\text{C}_{10}&space;\&space;\text{dev}(\hat{\mathbf{C}})&space;\mathbf{C}^{-1}&space;&plus;&space;\kappa&space;(J-1)&space;J&space;\mathbf{C}^{-1}" title="\mathbf{S} = 2\text{C}_{10} \ \text{dev}(\hat{\mathbf{C}}) \mathbf{C}^{-1} + \kappa (J-1) J \mathbf{C}^{-1}" /></a>

By evaluating the derivative of the stress with respect to one half of the right Cauchy-Green deformation tensor we get the material elasticity tensor:

<a href="https://www.codecogs.com/eqnedit.php?latex=\mathbb{C}&space;=&space;\frac{\partial&space;\mathbf{S}}{\partial\frac{1}{2}\mathbf{C}}" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\mathbb{C}&space;=&space;\frac{\partial&space;\mathbf{S}}{\partial\frac{1}{2}\mathbf{C}}" title="\mathbb{C} = \frac{\partial \mathbf{S}}{\partial\frac{1}{2}\mathbf{C}}" /></a>

<a href="https://www.codecogs.com/eqnedit.php?latex=\mathbb{C}&space;=&space;2\text{C}_{10}&space;J^{-2/3}&space;\frac{2}{3}&space;\&space;(\text{tr}(\mathbf{C})&space;\&space;\mathbb{I}&space;-&space;\mathbf{1}&space;\otimes&space;\mathbf{C}^{-1}&space;-&space;\mathbf{C}^{-1}&space;\otimes&space;\mathbf{1}&space;&plus;&space;\frac{1}{3}&space;\text{tr}(\mathbf{C})&space;\&space;\mathbf{C}^{-1}&space;\otimes&space;\mathbf{C}^{-1})&space;&plus;&space;\left(\kappa&space;(J-1)&space;J&space;&plus;&space;\kappa&space;J^2\right)&space;\&space;\mathbf{C}^{-1}&space;\otimes&space;\mathbf{C}^{-1}&space;-&space;2&space;\kappa&space;(J-1)&space;J&space;\&space;\mathbb{I}" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\mathbb{C}&space;=&space;2\text{C}_{10}&space;J^{-2/3}&space;\frac{2}{3}&space;\&space;(\text{tr}(\mathbf{C})&space;\&space;\mathbb{I}&space;-&space;\mathbf{1}&space;\otimes&space;\mathbf{C}^{-1}&space;-&space;\mathbf{C}^{-1}&space;\otimes&space;\mathbf{1}&space;&plus;&space;\frac{1}{3}&space;\text{tr}(\mathbf{C})&space;\&space;\mathbf{C}^{-1}&space;\otimes&space;\mathbf{C}^{-1})&space;&plus;&space;\left(\kappa&space;(J-1)&space;J&space;&plus;&space;\kappa&space;J^2\right)&space;\&space;\mathbf{C}^{-1}&space;\otimes&space;\mathbf{C}^{-1}&space;-&space;2&space;\kappa&space;(J-1)&space;J&space;\&space;\mathbb{I}" title="\mathbb{C} = 2\text{C}_{10} J^{-2/3} \frac{2}{3} \ (\text{tr}(\mathbf{C}) \ \mathbb{I} - \mathbf{1} \otimes \mathbf{C}^{-1} - \mathbf{C}^{-1} \otimes \mathbf{1} + \frac{1}{3} \text{tr}(\mathbf{C}) \ \mathbf{C}^{-1} \otimes \mathbf{C}^{-1}) + \left(\kappa (J-1) J + \kappa J^2\right) \ \mathbf{C}^{-1} \otimes \mathbf{C}^{-1} - 2 \kappa (J-1) J \ \mathbb{I}" /></a>

with the fourth order identity tensor

<a href="http://www.codecogs.com/eqnedit.php?latex=\mathbb{I}=&space;\mathbf{C}^{-1}&space;\odot&space;\mathbf{C}^{-1}" target="_blank"><img src="http://latex.codecogs.com/gif.latex?\mathbb{I}=&space;\mathbf{C}^{-1}&space;\odot&space;\mathbf{C}^{-1}" title="\mathbb{I}= \mathbf{C}^{-1} \odot \mathbf{C}^{-1}" /></a>

<a href="http://www.codecogs.com/eqnedit.php?latex=\mathbf{C}^{-1}&space;=&space;\mathbb{I}&space;:&space;\mathbf{C}" target="_blank"><img src="http://latex.codecogs.com/gif.latex?\mathbf{C}^{-1}&space;=&space;\mathbb{I}&space;:&space;\mathbf{C}" title="\mathbf{C}^{-1} = \mathbb{I} : \mathbf{C}" /></a>

The two equations are now implemented in a Total Lagrange user subroutine  with the help of this Tensor module as follows:

```fortran
      include 'ttb/ttb_library.f'

      subroutine hypela2(d,g,e,de,s,t,dt,ngens,m,nn,kcus,matus,ndi,
     2             nshear,disp,dispt,coord,ffn,frotn,strechn,eigvn,ffn1,
     3                   frotn1,strechn1,eigvn1,ncrd,itel,ndeg,ndm,
     4                   nnode,jtype,lclass,ifr,ifu)
     
      ! HYPELA2:        Nearly-Incompressible Neo-Hookean Material
      !                 Example for usage of Tensor Toolbox
      ! capability:     axisymmetric and 3D analysis
      ! Formulation:    Total Lagrange
      ! Voigt Notation: change commented Tensor Datatypes
      ! Andreas Dutzler, 2018-01-02, Graz University of Technology

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
      
      type(Tensor2)  :: F1
      real(kind=8) :: J,kappa,C10
      
      ! to use voigt notation change to type Tensor2s, Tensor4s
      type(Tensor2) :: C1,invC1,S1,Eye
      type(Tensor4) :: C4
      
      ! material parameters
      C10 = 0.5
      kappa = 500.0
      
      Eye = identity2(Eye)
      F1 = ffn1(1:3,1:3) ! use slices (ffn1 is an assumed size array)
      J = det(F1)
      
      ! right cauchy-green deformation tensor and it's inverse
      C1 = transpose(F1)*F1
      invC1 = inv(C1) ! faster method: invC1 = inv(C1,J**2)
      
      ! pk2 stress
      S1 = 2.*C10*J**(-2./3.)*dev(C1)*invC1 + kappa*(J-1)*J*invC1

      ! material elasticity tensor
      C4 = 2.*C10 * J**(-2./3.) * 2./3. *
     *  ( tr(C1) * (invC1.cdya.invC1)
     *    - (Eye.dya.invC1) - (invC1.dya.Eye)
     *    + tr(C1)/3. * (invC1.dya.invC1) )
     *  + (kappa*(J-1)*J+kappa*J**2) * (invC1.dya.invC1)
     *  - 2.*kappa*(J-1)*J* (invC1.cdya.invC1)
     
      ! output as array
      s(1:ngens)         = asarray( voigt(S1), ngens )
      d(1:ngens,1:ngens) = asarray( voigt(C4), ngens, ngens )
      
      return
      end
```

There are also examples for a [basic understandig of the tensor toolbox](examples/script_umat.f) and a [full featured MSC.Marc Neo-Hookean material HYPELA2 user subroutine](examples/hypela2_nh_ttb.f).
