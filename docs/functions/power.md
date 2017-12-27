## Power

**Description:** Multiply a Tensor i-times by itself. Note that for a given Tensor C:
- `i < 0` calculate inv(C)
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

! inverse of C
invC = C**(-1)

! identity tensor
Eye = C**0
```

