---
title: As Array
layout: page
nav_order: 3
parent: Functions
grand_parent: API Reference
---

## As Array

Convert Tensor to Array. This is useful to export results back to the code which is not using the tensor toolbox.

{: .note }
> This function is very useful because Fortran does not allow access to Tensor components of a function result `s = (dev(S*C)*inv(C))%ab`. Instead this function can be used.

{: .warning }
> If you use Abaqus please use [`asabqarray`]({% link api/functions/asabqarray.md %}) to export Tensor components.

`asarray` is called with one (rank 2) or two (rank 4) integers to slice dimensions. This is useful if an axisymmetric analysis is evaluated (3 direct and 1 shear components = 4x4 tangent matrix instead of full 6x6 storage).

| Property   | Value                  |
| ---        | ---                    |
| Result     | array                  |
| Data Types | `Tensor2`, `Tensor2s`, `Tensor4`, `Tensor4s`  |

### Example

```fortran
type(Tensor2)  :: S1
type(Tensor4)  :: C4
! type(Tensor2s)  :: S1
! type(Tensor4s)  :: C4

integer :: ndim

real(kind=8), dimension(ndim)      :: s
real(kind=8), dimension(ndim,ndim) :: d

s(1:ndim)         = asarray( voigt(S1), ndim )
d(1:ndim, 1:ndim) = asarray( voigt(C4), ndim, ndim )
```
