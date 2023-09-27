---
title: Neo-Hooke (Marc)
layout: page
nav_order: 4
parent: Examples
---

## Neo-Hooke (Marc)

This is a very basic example on how to implement a nearly-incompressible version of the Neo-Hookean material model in a commercial FEM package (HYPELA2 for Marc). As no special two- or three-field variational principle is used in this example, it is not suitable for nearly-incompressible material behaviour. Otherwise the elements tend to show excessive volumetric locking during deformation and hence, wrong results are calculated.

The strain energy density function per unit reference volume is additively splitted into an isochoric and volumetric contribution, see Eq. $$\eqref{eq:psi}$$. The first one is assumed to be proportional to the first invariant of the isochoric part of the right Cauchy-Green deformation tensor whereas the volumetric part is only a function of the volumetric ratio (the determinant of the deformation gradient), see Eq. $$\eqref{eq:psi-nh}$$.

$$
\begin{align}
  \psi(\mathbf{C}) &= \psi(\mathbf{\hat C}) + U(J) \nonumber \\
  \psi(\mathbf{C}) &= \text{C}_{10} (\text{I}_\mathbf{\hat C}-3) + \frac{\kappa}{2} (J-1)^2
  \label{eq:psi-nh}
\end{align}
$$

We get the second Piola-Kirchhoff stress with the derivative of the strain energy density function per unit reference volume with respect to one half of the right Cauchy-Green deformation tensor as shown in Eq. $$\eqref{eq:pk2-nh}$$.

$$
\begin{align}
  \mathbf{S} &= \frac{\partial \psi(\mathbf{C})}{\partial \frac{1}{2}\mathbf{C}} \nonumber \\
  \mathbf{S} &= 2\text{C}_{10} \ \text{dev}(\hat{\mathbf{C}}) \mathbf{C}^{-1} + \kappa (J-1) J \mathbf{C}^{-1}
  \label{eq:pk2-nh}
\end{align}
$$

By evaluating the derivative of the stress with respect to one half of the right Cauchy-Green deformation tensor we get the material elasticity tensor, see Eq. $$\eqref{eq:c4-nh}$$,

$$
\begin{equation}
  \mathbb{C} = \frac{\partial \mathbf{S}}{\partial\frac{1}{2}\mathbf{C}}
  \label{eq:c4}
\end{equation}
$$

$$
\begin{align}
  \mathbb{C} &= 2\text{C}_{10} J^{-2/3} \frac{2}{3} \ (\text{tr}(\mathbf{C}) \ \mathbb{I} - \mathbf{1} \otimes \mathbf{C}^{-1} - \mathbf{C}^{-1} \otimes \mathbf{1} + \frac{1}{3} \text{tr}(\mathbf{C}) \ \mathbf{C}^{-1} \otimes \mathbf{C}^{-1}) \nonumber \\
  &+ \left(\kappa (J-1) J + \kappa J^2\right) \ \mathbf{C}^{-1} \otimes \mathbf{C}^{-1} - 2 \kappa (J-1) J \ \mathbb{I}
  \label{eq:c4-nh}
\end{align}
$$

with the fourth order identity tensor in Eq. $$\eqref{eq:i4}$$.

$$
\begin{align}
  \mathbb{I} &= \mathbf{C}^{-1} \odot \mathbf{C}^{-1} \nonumber \\
  \mathbf{C}^{-1} &= \mathbb{I} : \mathbf{C} \label{eq:i4}
\end{align}
$$

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

There are also examples for a [basic understandig of the tensor toolbox](script_umat.f), the implementation of the [St.Venant Kirchhoff material](example_stvenantkirchhoff.md) and a [full featured Marc Neo-Hookean material HYPELA2 user subroutine](hypela2_nh_ttb.f).
