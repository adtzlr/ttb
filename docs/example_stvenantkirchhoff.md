## Example: St. Venant Kirchhoff Material

The following example discusses the implementation of a St.Venant-Kirchhoff material in a very simple and readable user subroutine. The St.Venant-Kirchhoff material is possibly the simplest example for a hyperelastic material but suffers from practical relevance beyond the small strain range [1]. Anyway, it's a good starting point because stress tensor and elasticity matrix are of the same form as the linear elasticity formulation, except that Green-Lagrange strains are used.

## Kinematics
Starting from the Deformation Gradient, we calculate the Green-Lagrange strain tensor with the right Cauchy Green Deformation Tensor with

<a href="https://www.codecogs.com/eqnedit.php?latex=\boldsymbol{E}&space;=&space;\frac{1}{2}&space;(\boldsymbol{C}&space;-&space;\boldsymbol{1})" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\boldsymbol{E}&space;=&space;\frac{1}{2}&space;(\boldsymbol{C}&space;-&space;\boldsymbol{1})" title="\boldsymbol{E} = \frac{1}{2} (\boldsymbol{C} - \boldsymbol{1})" /></a>

and 

<a href="https://www.codecogs.com/eqnedit.php?latex=\boldsymbol{C}&space;=&space;\boldsymbol{F}^T&space;\boldsymbol{F}" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\boldsymbol{C}&space;=&space;\boldsymbol{F}^T&space;\boldsymbol{F}" title="\boldsymbol{C} = \boldsymbol{F}^T \boldsymbol{F}" /></a>

## Subroutine Header for user materials
Before we are able to add our own user code, we have to start with an empty fortran subroutine header for MSC.Marc's HYPELA2. Similar headers are provided for Abaqus, ANSYS, etc in the corresponding manuals.

```fortran
      include 'ttb/ttb_library.f'

      subroutine hypela2(d,g,e,de,s,t,dt,ngens,m,nn,kcus,matus,ndi,
     2             nshear,disp,dispt,coord,ffn,frotn,strechn,eigvn,ffn1,
     3                   frotn1,strechn1,eigvn1,ncrd,itel,ndeg,ndm,
     4                   nnode,jtype,lclass,ifr,ifu)

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
      
      ! ...user code...
      
      return
      end
```

First we need to define our material parameters, which will be entered as young's modulus and poisson ratio.

```fortran
      real(kind=8) :: young,nu,lambda,mu
      
      ! material parameters
      young = 210000.0
      nu = 0.3
      
      ! lame parameter
      mu = young / ( 2.*(1.+nu) )
      lambda = nu*young / ((1.+nu)*(1.-2.*nu))
```

In our code implementation the strain tensor looks like:

```fortran
      type(Tensor2)  :: F1
      type(Tensor2s) :: E1,Eye
      
      Eye = Eye**0
      
      F1 = Eye
      F1%ab(1:itel,1:3) = ffn1(1:itel,1:3)
      
      E1 = 0.5*(transpose(F1)*F1-Eye)
```

We first initialize a rank 2 Identity Tensor `Eye`. Then the Deformation Gradient Tensor at the end of the increment `F1` is initialized with no deformation and overwritten by `ffn1` with dimension `(itel,3)` where `itel` being an integer `2` or `3` based on the analysis type. This is necessary because this module is hardcoded to three dimensions whereas MSC.Marc has reduced storage options for the Deformation Gradient in plane or axisymmetric analysis types. Finally we calculate the Green-Lagrange Strain Tensor.

## Strain Energy Potential
We'll derive both stress and elasticity tensor in the material (reference) configuration. At first we need the definition for the helmholtz free energy per unit reference volume which depends on the Green-Lagrange strain tensor.

<a href="https://www.codecogs.com/eqnedit.php?latex=\Psi(\boldsymbol{E})&space;=&space;\frac{1}{2}&space;\lambda(\text{tr}\boldsymbol{E})^2&plus;\mu&space;\boldsymbol{E}&space;:&space;\boldsymbol{E}" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\Psi(\boldsymbol{E})&space;=&space;\frac{1}{2}&space;\lambda(\text{tr}\boldsymbol{E})^2&plus;\mu&space;\boldsymbol{E}&space;:&space;\boldsymbol{E}" title="\Psi(\boldsymbol{E}) = \frac{1}{2} \lambda(\text{tr}\boldsymbol{E})^2+\mu \boldsymbol{E} : \boldsymbol{E}" /></a>

## Material Stress Tensor
In the next step, we get the 2nd Piola-Kirchhoff stress tensor as a partial derivative of the strain energy potential with respect to the Green-Lagrange strain tensor.

<a href="https://www.codecogs.com/eqnedit.php?latex=\boldsymbol{S}&space;=&space;\frac{\partial&space;\Psi(\boldsymbol{E})}{\partial&space;\boldsymbol{E}}&space;=&space;\lambda(\text{tr}\boldsymbol{E})&space;\boldsymbol{1}&space;&plus;&space;2&space;\mu&space;\boldsymbol{E}" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\boldsymbol{S}&space;=&space;\frac{\partial&space;\Psi(\boldsymbol{E})}{\partial&space;\boldsymbol{E}}&space;=&space;\lambda(\text{tr}\boldsymbol{E})&space;\boldsymbol{1}&space;&plus;&space;2&space;\mu&space;\boldsymbol{E}" title="\boldsymbol{S} = \frac{\partial \Psi(\boldsymbol{E})}{\partial \boldsymbol{E}} = \lambda(\text{tr}\boldsymbol{E}) \boldsymbol{1} + 2 \mu \boldsymbol{E}" /></a>

Inside our subroutine the stress tensor is

```fortran
      type(Tensor2s) :: S1
      	  
      ! ...some code...
      
      S1 = lambda*tr(E1)*Eye + 2.*mu*E1
```

## Material Elasticity Tensor
With the second derivative of the strain energy potential we get the corresponding elasticity tensor.

<a href="https://www.codecogs.com/eqnedit.php?latex=\mathbb{C}&space;=&space;\frac{\partial^2&space;\Psi(\boldsymbol{E})}{\partial&space;\boldsymbol{E}&space;\partial&space;\boldsymbol{E}}&space;=&space;\lambda&space;\boldsymbol{1}&space;\otimes&space;\boldsymbol{1}&space;&plus;&space;2&space;\mu&space;\mathbb{I}^{(s)}" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\mathbb{C}&space;=&space;\frac{\partial^2&space;\Psi(\boldsymbol{E})}{\partial&space;\boldsymbol{E}&space;\partial&space;\boldsymbol{E}}&space;=&space;\lambda&space;\boldsymbol{1}&space;\otimes&space;\boldsymbol{1}&space;&plus;&space;2&space;\mu&space;\mathbb{I}^{(s)}" title="\mathbb{C} = \frac{\partial^2 \Psi(\boldsymbol{E})}{\partial \boldsymbol{E} \partial \boldsymbol{E}} = \lambda \boldsymbol{1} \otimes \boldsymbol{1} + 2 \mu \mathbb{I}^{(s)}" /></a>

Or in index notation:

<a href="https://www.codecogs.com/eqnedit.php?latex=\mathbb{C}^{IJKL}&space;=&space;\lambda&space;\Delta^{IJ}&space;\Delta^{KL}&space;&plus;&space;2&space;\mu&space;~\frac{1}{2}&space;(&space;\Delta^{IK}&space;\Delta^{JL}&space;&plus;&space;\Delta^{IL}&space;\Delta^{JK})" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\mathbb{C}^{IJKL}&space;=&space;\lambda&space;\Delta^{IJ}&space;\Delta^{KL}&space;&plus;&space;2&space;\mu&space;~\frac{1}{2}&space;(&space;\Delta^{IK}&space;\Delta^{JL}&space;&plus;&space;\Delta^{IL}&space;\Delta^{JK})" title="\mathbb{C}^{IJKL} = \lambda \Delta^{IJ} \Delta^{KL} + 2 \mu ~\frac{1}{2} ( \Delta^{IK} \Delta^{JL} + \Delta^{IL} \Delta^{JK})" /></a>

Again, in our fortran subroutine the code for this elasticity tensor is as follows:

```fortran
      type(Tensor4s) :: C4
      
      ! ...some code...
      
      C4 = lambda*(Eye.dya.Eye) + 2.*mu*(Eye.cdya.Eye)
```

The crossed dyadic product is implemented as the symmetric variant in this module, so writing `Eye.cdya.Eye` is enough for the symmetric version of the rank 4 Identity Tensor.

Finally we have to export our Tensor data types back to conventional fortran arrays. The integer `ngens = ndi + nshear` is based on the analysis dimension. 

```fortran
      ! output as array
      s(1:ngens)         = asarray( asvoigt(S1), ngens )
      d(1:ngens,1:ngens) = asarray( asvoigt(C4), ngens,ngens )
```

If we would like to use the Updated Lagrange framework too, we'll have to check whether updated or total lagrange framework is active. Please note that for the updated lagrange framework it is common to use the jaumann rate of kirchhoff stress in commercial FE codes. First, the tangent matrix is pushed forward to spatial components `(i,j,k,l)`, divided by the volumetric ratio `J` and then transformed from the truesdell rate of kirchhoff stress to the jaumann rate of kirchhoff stress. For the elasticity tensor conversion have a look at Maria Holland's Hitchhiker's Guide to Abaqus [2].

```fortran
      real(kind=8) :: J
      
      ! ...some code...
      
      if (iupdat.eq.1) then ! updated lagrange
       J = det(F1)
       ! cauchy stress
       S1 = piola(F1,S1)/J
       ! tangent matrix (jaumann)
       C4 = piola(F1,C4)/J
     *      + (S1.cdya.Eye) + (Eye.cdya.S1)
      endif
```

In this code `iupdat` is an integer with `0` for total lagrange and `1` for updated lagrange. You may download the whole example as a [HYPELA2 user subroutine](examples/hypela2_stvenantkirchhoff.f) for MSC.Marc.

## Sources
[1] Bonet, J., Gil, A. J., & Wood, R. D. (2016). Nonlinear Solid Mechanics for Finite Element Analysis: Statics. Cambridge University Press. https://doi.org/10.1017/cbo9781316336144

[2] Holland, M. (2018, May 7). Mholla/Hitchhikers-Guide-To-Abaqus: Initial Release (Version v1.0). Zenodo. https://doi.org/10.5281/zenodo.1243270 