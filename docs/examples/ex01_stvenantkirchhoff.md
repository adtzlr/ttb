---
title: Ex. 01 - Saint Venant-Kirchhoff
layout: page
nav_order: 4
parent: Examples
---

# Saint Venant-Kirchhoff

The following example discusses the implementation of a Saint Venant-Kirchhoff material in a very simple and readable user subroutine. The Saint Venant-Kirchhoff material is possibly the simplest example for a hyperelastic material but suffers from practical relevance beyond the small strain range [1]. Anyway, it's a good starting point because stress tensor and elasticity matrix are of the same form as the linear elasticity formulation, except that Green-Lagrange strains are used.

## Kinematics
Starting from the Deformation Gradient, we calculate the Green-Lagrange strain tensor in Eq. $$\eqref{eq:gl-strain}$$ with the right Cauchy-Green deformation tensor, see Eq. $$\eqref{eq:cauchy-green}$$.

$$
\begin{equation}
  \boldsymbol{E} = \frac{1}{2} (\boldsymbol{C} - \boldsymbol{1}) \label{eq:gl-strain}
\end{equation}
$$

and

$$
\begin{equation}
  \boldsymbol{C} = \boldsymbol{F}^T \boldsymbol{F} \label{eq:cauchy-green}
\end{equation}
$$

## Subroutine Header for user materials
Before we are able to add our own user code, we have to start with an empty fortran subroutine header. Headers are provided e.g. for Marc, Abaqus, Dyna, ANSYS in their corresponding manuals.

<details markdown="block">
<summary>Header for Marc</summary>

### HYPELA2 for Marc

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

</details>

<details markdown="block">
<summary>Header for Abaqus</summary>

### UMAT for Abaqus

```fortran
      include 'ttb/ttb_library.f'

      SUBROUTINE UMAT(STRESS,STATEV,DDSDDE,SSE,SPD,SCD,
     1 RPL,DDSDDT,DRPLDE,DRPLDT,
     2 STRAN,DSTRAN,TIME,DTIME,TEMP,DTEMP,PREDEF,DPRED,CMNAME,
     3 NDI,NSHR,NTENS,NSTATV,PROPS,NPROPS,COORDS,DROT,PNEWDT,
     4 CELENT,DFGRD0,DFGRD1,NOEL,NPT,LAYER,KSPT,JSTEP,KINC)

      use Tensor
      implicit none

      CHARACTER*80 CMNAME
      DIMENSION STRESS(NTENS),STATEV(NSTATV),
     1 DDSDDE(NTENS,NTENS),DDSDDT(NTENS),DRPLDE(NTENS),
     2 STRAN(NTENS),DSTRAN(NTENS),TIME(2),PREDEF(1),DPRED(1),
     3 PROPS(NPROPS),COORDS(3),DROT(3,3),DFGRD0(3,3),DFGRD1(3,3),
     4 JSTEP(4)

      ! ...user code...

      return
      end
```

</details>

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
      F1%ab(1:3,1:3) = ffn1(1:3,1:3)

      E1 = 0.5*(transpose(F1)*F1-Eye)
```

We first initialize a rank 2 Identity Tensor `Eye`. Then the Deformation Gradient Tensor at the end of the increment `F1` is initialized with no deformation and overwritten by `ffn1` with dimension `(itel,3)` where `itel` being an integer `2` or `3` based on the analysis type. This is necessary because this module is hardcoded to three dimensions whereas MSC.Marc has reduced storage options for the Deformation Gradient in plane or axisymmetric analysis types. Finally we calculate the Green-Lagrange Strain Tensor.

## Strain Energy Potential
We'll derive both stress and elasticity tensor in the material (reference) configuration. At first we need the definition for the strain energy density function per unit reference volume which depends on the Green-Lagrange strain tensor, see Eq. $$\eqref{eq:psi-svk}$$.

$$
\begin{equation}
  \psi(\boldsymbol{E}) = \frac{1}{2} \lambda(\text{tr}\boldsymbol{E})^2+\mu \boldsymbol{E} : \boldsymbol{E}
  \label{eq:psi-svk}
\end{equation}
$$

## Material Stress Tensor
In the next step, we get the 2nd Piola-Kirchhoff stress tensor as a partial derivative of the strain energy potential with respect to the Green-Lagrange strain tensor, see Eq. $$\eqref{eq:pk2-svk}$$.

$$
\begin{equation}
  \boldsymbol{S} = \frac{\partial \psi(\boldsymbol{E})}{\partial \boldsymbol{E}} = \lambda(\text{tr}\boldsymbol{E}) \boldsymbol{1} + 2 \mu \boldsymbol{E}
  \label{eq:pk2-svk}
\end{equation}
$$

Inside our subroutine the stress tensor is

```fortran
      type(Tensor2s) :: S1

      S1 = lambda*tr(E1)*Eye + 2.*mu*E1
```

## Material Elasticity Tensor
With the second derivative of the strain energy potential we get the corresponding elasticity tensor, see Eq. $$\eqref{eq:c4-svk}$$.

$$
\begin{equation}
  \mathbb{C} = \frac{\partial^2 \psi(\boldsymbol{E})}{\partial \boldsymbol{E} \partial \boldsymbol{E}} = \lambda \boldsymbol{1} \otimes \boldsymbol{1} + 2 \mu \boldsymbol{1} \odot \boldsymbol{1}
  \label{eq:c4-svk}
\end{equation}
$$

Again, in our fortran subroutine the code for this elasticity tensor is as follows:

```fortran
      type(Tensor4s) :: C4

      C4 = lambda*(Eye.dya.Eye) + 2.*mu*(Eye.cdya.Eye)
```

The crossed dyadic product is implemented as the symmetric variant in this module, so writing `Eye.cdya.Eye` is enough for the symmetric version of the rank 4 Identity Tensor.

## Export as Array
Finally we have to export our Tensor data back to conventional fortran arrays.

<details markdown="block">
<summary>Export for Marc</summary>

{: .important }
> If we would like to use the Updated Lagrange framework in Marc, we'll have to check whether the updated or the total lagrange framework is active. Please note that for the updated lagrange framework it is common to use the jaumann rate of kirchhoff stress in commercial FE codes. First, the tangent matrix is pushed forward to spatial components `(i,j,k,l)`, divided by the volumetric ratio `J` and then transformed to the jaumann rate of kirchhoff stress. For the elasticity tensor conversion have a look at Maria Holland's Hitchhiker's Guide to Abaqus [2].

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

In this code `iupdat` is an integer with

* `0` for total lagrange and
* `1` for updated lagrange.

```fortran
      ! output as array
      s(1:ngens)         = asarray( asvoigt(S1), ngens )
      d(1:ngens,1:ngens) = asarray( asvoigt(C4), ngens, ngens )
```

You may download the example as a [HYPELA2 user subroutine](Marc/hypela2_stvenantkirchhoff.f) for Marc.

</details>

<details markdown="block">
<summary>Export for Abaqus</summary>

{: .important }
> Abaqus uses the Updated Lagrange framework. Please note that for the updated lagrange framework it is common to use the jaumann rate of kirchhoff stress in commercial FE codes. First, the tangent matrix is pushed forward to spatial components `(i,j,k,l)`, divided by the volumetric ratio `J` and then transformed to the jaumann rate of kirchhoff stress. For the elasticity tensor conversion have a look at Maria Holland's Hitchhiker's Guide to Abaqus [2].

```fortran
      ! push forward to cauchy stress
      J = det(F1)
      S1 = piola(F1,S1)/J

      ! push forward to jaumann tangent of cauchy stress for abaqus
      C4 = piola(F1,C4)/J + (S1.cdya.Eye)+(Eye.cdya.S1)

      ! output as abaqus array
      STRESS(1:ntens)         = asabqarray( voigt(S1), ntens )
      DDSDDE(1:ntens,1:ntens) = asabqarray( voigt(C4), ntens, ntens )
```

</details>

## References
[1] Bonet, J., Gil, A. J., & Wood, R. D. (2016). Nonlinear Solid Mechanics for Finite Element Analysis: Statics. Cambridge University Press. [![DOI:10.1017/cbo9781316336144](https://zenodo.org/badge/DOI/10.1017/cbo9781316336144.svg)](https://doi.org/10.1017/cbo9781316336144)

[2] Holland, M. (2018, May 7). Mholla/Hitchhikers-Guide-To-Abaqus: Initial Release (Version v1.0). Zenodo. [![DOI:10.5281/zenodo.1243270](https://zenodo.org/badge/DOI/10.5281/zenodo.1243270.svg)](https://doi.org/10.5281/zenodo.1243270)
