---
title: Norm
layout: page
nav_order: 3
parent: Functions
grand_parent: API Reference
---

## Norm

Euclidean norm of a rank 1 Tensor (Vector). Square root of the sum of the squared components `sqrt( sum( T%a**2 ))`.

| Property   | Value                  |
| ---        | ---                    |
| Result     | Scalar-valued function |
| Data Types | `Tensor1`              |

### Example

```fortran
type(Tensor1) :: v
real(kind=8)  :: norm_v

norm_v = norm(v)
```
