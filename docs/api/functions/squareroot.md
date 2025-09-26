---
title: Matrix Square Root
layout: page
nav_order: 3
parent: Functions
grand_parent: API Reference
---

## Square Root

Tensorial (matrix) square root of a positive definite rank 2 Tensor. For algorithmic details see [Franka, L.P. (1988)](https://inis.iaea.org/search/search.aspx?orig_q=RN:20064555). This function can be used to obtain the stretch tensor. For a rank 1 Tensor (vector), the element-wise square root is returned.

$$
\begin{align}
  \mathbf{C} &= \mathbf{U}^2 \\
  \mathbf{U} &= \sqrt{\mathbf{C}}
\end{align}
$$

| Property   | Value                  |
| ---        | ---                    |
| Result     | Tensor-valued function |
| Data Types | `Tensor2`, `Tensor2s`  |

### Example

```fortran
type(Tensor2)  :: F, R

type(Tensor2)  :: U, C
! type(Tensor2s) :: U, C

C = transpose(F)*F
U = sqrt(C)

! polar decomposition F = R*U
R = F*inv(U)
```
