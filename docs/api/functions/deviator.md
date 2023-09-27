---
title: Deviator
layout: page
nav_order: 3
parent: Functions
grand_parent: API Reference
---

## Deviator

Deviator of a rank 2 Tensor.

$$
\begin{equation}
  \text{dev}(\mathbf{C}) = \mathbf{C} - \frac{\text{tr}(\mathbf{C})}{3} \mathbf{1}
\end{equation}
$$

| Property   | Value                  |
| ---        | ---                    |
| Result     | Tensor-valued function |
| Data Types | `Tensor2`, `Tensor2s`  |

### Example

```fortran
type(Tensor2)  :: C, devC
! type(Tensor2s) :: C, devC

devC = dev(C)
```
