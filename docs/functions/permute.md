## Permute

**Description:** Index permutation of a rank 2 or a rank 4 Tensor. For rank 2 Tensors this is equal to the transpose function.

| Property   | Value                                         |
| ---        | ---                                           |
| Result     | Tensor-valued function                        |
| Data Types | `Tensor2`, `Tensor2s`, `Tensor4`, `Tensor4s`  |

### Example

```fortran
type(Tensor2)  :: C, C_p
! type(Tensor2s) :: C, C_p

type(Tensor4)  :: C4, C4_p
! type(Tensor4s) :: C4, C4_p

C_p  = permute(C, 2,1)
C4_p = permute(C4,1,3,2,4)
