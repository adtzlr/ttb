## Exponential Map and Derivative

**Description:** Exponential Map and Derivative of a rank 2 Tensor according to *Miehe(2002): Homogenization of inelastic solid materials at (nite strains based on incremental minimization principles. Application to the texture analysis of polycrystals*.

### Exponential Map
| Property   | Value                  |
| ---        | ---                    |
| Result     | Tensor-valued function |
| Data Types | `Tensor2`, `Tensor2s`  |

### Derivative of Exponential Map
| Property   | Value                  |
| ---        | ---                    |
| Result     | Tensor-valued function |
| Data Types | ---                    |
| Input      | `Tensor2`, `Tensor2s`  |
| Output     | `Tensor4`, `Tensor4s`  |

### Example

```fortran
type(Tensor2) :: C, expC
type(Tensor4) :: d_expC
! type(Tensor2s) :: C, expC
! type(Tensor4s) :: d_expC

expC = exp(C)
d_expC = derivative_exp(C)
```
