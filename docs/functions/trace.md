## Trace

**Description:** Sum of diagonal terms of a rank 2 Tensor.

| ---        | ---                    |
| Result     | Scalar-valued function |
| Data Types | `Tensor2`, `Tensor2s`  |

Markdown | Less | Pretty
--- | --- | ---
*Still* | `renders` | **nicely**
1 | 2 | 3

### Example

```fortran
type(Tensor2) :: T
real(kind=8)  :: trace

trace = tr(T)
```
