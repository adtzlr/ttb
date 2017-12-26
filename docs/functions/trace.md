## Trace

**Description:** Sum of diagonal terms of a rank 2 Tensor.

| A          | B                      |
| ---        | ---                    |
| Result     | Scalar-valued function |
| Data Types | `Tensor2`, `Tensor2s`  |

### Example

```fortran
type(Tensor2) :: T
real(kind=8)  :: trace

trace = tr(T)
```
