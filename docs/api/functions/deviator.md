---
title: Deviator
layout: page
nav_order: 3
parent: Functions
grandparent: API Reference
---

## Deviator

**Description:** Deviator of a rank 2 Tensor.

<a href="https://www.codecogs.com/eqnedit.php?latex=\text{dev}(\mathbf{C})&space;=&space;\mathbf{C}&space;-&space;\frac{\text{tr}(\mathbf{C})}{3}&space;\mathbf{1}" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\text{dev}(\mathbf{C})&space;=&space;\mathbf{C}&space;-&space;\frac{\text{tr}(\mathbf{C})}{3}&space;\mathbf{1}" title="\text{dev}(\mathbf{C}) = \mathbf{C} - \frac{\text{tr}(\mathbf{C})}{3} \mathbf{1}" /></a>

| Property   | Value                  |
| ---        | ---                    |
| Result     | Tensor-valued function |
| Data Types | `Tensor2`, `Tensor2s`  |

### Example

```fortran
type(Tensor2)  :: C, devC
! type(Tensor2s) :: C, devC

devC = dev(C)
```
