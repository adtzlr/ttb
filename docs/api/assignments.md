---
title: Assignments
layout: page
nav_order: 3
parent: API Reference
---

## Assignments

If there is a symmetric rank 2 tensor `type(Tensor2s) :: T2` on the left and a rank 2 tensor `type(Tensor2) :: T1` on the right hand side of the assignment `=` operator then the function `T2 = asvoigt(T1)` is automatically called. So it is possible to write the following examples:

```fortran
type(Tensor2) :: F
type(Tensor2) :: C ! full 3x3 tensor

C = transpose(F)*F
```

Now it is super simple to switch between full tensor and Voigt matrix storage with only one litte change:

```fortran
type(Tensor2) :: F
type(Tensor2s) :: C ! now stored as 6x1 matrix

C = transpose(F)*F
```

The same assignments are also possible for rank 4 Tensor data types.
