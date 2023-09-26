---
title: Transpose
layout: page
nav_order: 3
parent: Functions
grandparent: API Reference
---

## Transpose

**Description:** Transpose of a rank 2 Tensor or major transpose of a rank 4 Tensor.

| Property   | Value                                         |
| ---        | ---                                           |
| Result     | Tensor-valued function                        |
| Data Types | `Tensor2`, `Tensor2s`, `Tensor4`, `Tensor4s`  |

### Example

```fortran
type(Tensor2)  :: C, C_T
! type(Tensor2s) :: C, C_T

type(Tensor4)  :: C4, C4_T
! type(Tensor4s) :: C4, C4_T

C_T  = transpose(C)
C4_T = transpose(C4)
```
