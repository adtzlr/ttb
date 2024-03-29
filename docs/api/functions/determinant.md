---
title: Determinant
layout: page
nav_order: 3
parent: Functions
grand_parent: API Reference
---

## Determinant

Determinant of a rank 2 Tensor.

| Property   | Value                  |
| ---        | ---                    |
| Result     | Scalar-valued function |
| Data Types | `Tensor2`, `Tensor2s`  |

### Example

```fortran
type(Tensor2) :: T
real(kind=8)  :: det_T

det_T = det(T)
```
