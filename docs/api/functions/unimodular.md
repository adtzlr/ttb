---
title: Unimodular
layout: page
nav_order: 3
parent: Functions
grand_parent: API Reference
---

## Unimodular Part of Tensor

Unimodular Part of a rank 2 Tensor.

$$
\begin{equation}
\hat{\boldsymbol{C}} = \det({\boldsymbol{C}})^{-1/3} \ \boldsymbol{C}
\end{equation}
$$

| Property   | Value                  |
| ---        | ---                    |
| Result     | Tensor-valued function |
| Data Types | `Tensor2`, `Tensor2s`  |

### Example

```fortran
type(Tensor2)  :: C, hatC
! type(Tensor2s) :: C, hatC

hatC = unimodular(C)

print *, "proof:"
print *, (hatC - (det(C)**(-1./3.)*C))
```
