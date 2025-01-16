---
title: Inverse
layout: page
nav_order: 3
parent: Functions
grand_parent: API Reference
---

## Inverse

Inverse of a positive definite rank 2 Tensor (Determinant > 0).

Optional Argument
- Determinant

| Property   | Value                  |
| ---        | ---                    |
| Result     | Tensor-valued function |
| Data Types | `Tensor2`, `Tensor2s`  |

$$
\begin{equation}
\boldsymbol{C} \boldsymbol{C}^{-1} = \boldsymbol{1}
\end{equation}
$$

### Example

```fortran
type(Tensor2)  :: C, invC
! type(Tensor2s) :: C, invC
real(kind=8)   :: detC

invC = inv(C)

detC = det(C)
invC = inv(C, detC)
```
