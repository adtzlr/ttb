---
title: Identity
layout: page
nav_order: 3
parent: Functions
grand_parent: API Reference
---

## Identity

Calculate the identity tensor. Two functions for generating identities are implemented:

- `Eye = identity2(C)` calculate Eye with the same tensor data type as C. The components of C are ignored.
- `I4 = identity4(Eye)` calculate the symmetric fourth order identity tensor with the property `C = I4 : C`

For the fourth order variant the function argument is not only used for defining the data type. For example the fourth order "inverse-identity" tensor may be obtained with `I4invC = identity4(inv(C))` with the property `invC = I4invC : C`



| Property   | Value                  |
| ---        | ---                    |
| Result     | Tensor-valued function |
| Data Types | `Tensor2`, `Tensor2s`  |

### Example

```fortran

type(Tensor2)  :: C, invC, Eye
! type(Tensor2s) :: C, invC, Eye

type(Tensor4)  :: I4, I4invC
! type(Tensor4s) :: I4, I4invC

! the argument is only used for setting the data type
Eye = identity2(Eye)
Eye = identity2(C)

I4 = identity4(Eye)
C = I4**C
I4invC = identity4(inv(C))
invC = I4invC**C
```

**Note**: the operator `**` for two tensor data types represents a double contraction. See double contraction for details. `Eye.cdya.Eye` is equivalent to `identity4(Eye)`. See crossed-dyadic product for details.
