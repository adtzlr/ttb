---
title: Trace
layout: page
nav_order: 3
parent: Functions
grand_parent: API Reference
---

## Trace

Sum of diagonal terms of a rank 2 Tensor.

| Property   | Value                  |
| ---        | ---                    |
| Result     | Scalar-valued function |
| Data Types | `Tensor2`, `Tensor2s`  |

### Example

```fortran
type(Tensor2) :: T
real(kind=8)  :: trace

trace = tr(T)
```
