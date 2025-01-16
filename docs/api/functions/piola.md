---
title: Piola Transformation
layout: page
nav_order: 3
parent: Functions
grand_parent: API Reference
---

## Piola Transformation

Perform a Piola transformation. It is assumed that the tensor's components are all either co- or contravariant as this toolbox has no information about co- and contravariant tensor components. All indices are transformed with the same mixed-variant argument tensor. This means it is not possible to perform a push forward of a mixed variant fourth order tensor. To perform a push forward of the contra-variant indices of the tangent matrix from material components in the reference configuration to spatial components in the current configuration write `piola(F,C4)`. When using symmetric variants of tensor data types (Voigt-notation) a faster contraction with less calculations due to symmetric properties is performed.

- `piola(F,S)` where `S` is a stress tensor is equal to `F*S*transpose(F)`
- `piola(F,C4)` where `C4` is a fourth order elasticity tensor means `c4(i,j,k,l) = F(i,I) F(j,J) F(k,K) F(l,L) C4(I,J,K,L)`

| Property   | Value                                         |
| ---        | ---                                           |
| Result     | Tensor-valued function                        |
| Data Types | `Tensor2`, `Tensor2s`, `Tensor4`, `Tensor4s`  |

### Example

```fortran

real(kind=8) :: J

type(Tensor2)  :: F, S
! type(Tensor2s) :: S

type(Tensor4)  :: C4
! type(Tensor4s) :: C4

J = det(F)

! push forward of (contra-variant) PK2 stress tensor
tau = 1./J * piola(F,S)

! is equal to
Sigma = 1./J * F*S*transpose(F)

! push forward of (contra-variant) fourth order material elasticity tensor
c4 = 1./J * piola(F,C4)
```
