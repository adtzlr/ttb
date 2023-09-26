---
title: Unimodular
layout: page
nav_order: 3
parent: Functions
grand_parent: API Reference
---

## Unimodular Part of Tensor

**Description:** Unimodular Part of a rank 2 Tensor.

<a href="https://www.codecogs.com/eqnedit.php?latex=\hat{\textbf{C}}&space;=&space;\det({\textbf{C}})^{-1/3}&space;\&space;\textbf{C}" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\hat{\textbf{C}}&space;=&space;\det({\textbf{C}})^{-1/3}&space;\&space;\textbf{C}" title="\hat{\textbf{C}} = \det({\textbf{C}})^{-1/3} \ \textbf{C}" /></a>

| Property   | Value                  |
| ---        | ---                    |
| Result     | Tensor-valued function |
| Data Types | `Tensor2`, `Tensor2s`  |

### Example

```fortran
type(Tensor2)  :: C, hatC
! type(Tensor2s) :: C, hatC

hatC = unimodular(C)

print *, "proof:"
print *, (hatC - (det(C)**(-1./3.)*C))
```
