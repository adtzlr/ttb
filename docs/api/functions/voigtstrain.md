---
title: Voigtstrain
layout: page
nav_order: 3
parent: Functions
grand_parent: API Reference
---

## Voigtstrain

Import a strain array in voigt storage. As this Module does not use doubled shear items for the symmetric voigt-like storage a strain-like array has to be imported rather than assigned to a Tensor.
- `ndi` number of direct compononets
- `nshear` number of shear components
- `ngens` dimension of strain array

| Property   | Value                          |
| ---        | ---                            |
| Result     | Tensor-valued function         |
| Input      | `E(ngens)`, ndi, nshear, ngens |
| Output     | `Tensor2s`                     |

### Example

```fortran

       integer :: ndi,nshear,ngens
       real(kind=8), dimension(ngens) :: e

       type(Tensor2s)  :: C, Eye

       Eye = identity2(Eye)
       C = Eye + 2.*voigtstrain(e,ndi,nshear,ngens)
```
