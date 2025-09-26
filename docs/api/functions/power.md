---
title: Power
layout: page
nav_order: 3
parent: Functions
grand_parent: API Reference
---

## Power

Multiply a Tensor i-times by itself. Note that for a given Tensor C:
- `i < 0` calculate the i-th power of inv(C)
- `i == 0` calculate the identity tensor
- `i > 0` calculate the i-th power of C

| Property   | Value                  |
| ---        | ---                    |
| Result     | Tensor-valued function |
| Data Types | `Tensor2`, `Tensor2s`  |

### Example

```fortran

type(Tensor2)  :: C, C3, invC, Eye
! type(Tensor2s) :: C, C3, invC, Eye

! i-th power of C
C3 = C**3

! i-th power of inverse of C
invC3 = C**(-3)

! identity tensor
Eye = C**0
```

{: .warning }
> Don't use `C**(1/2)` because in Fortran an integer division, e.g. `1/2`, gives an integer `0` and this function will return the identity tensor instead of the square root.

{: .important }
> For the evaluation of the tensorial square root, use [sqrt]({% link api/functions/squareroot.md %}) instead.
