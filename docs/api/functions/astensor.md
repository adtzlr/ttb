---
title: As Tensor
layout: page
nav_order: 3
parent: Functions
grand_parent: API Reference
---

## As Tensor

Converts a `Tensor2s` or `Tensor4s` data type to a full tensor storage `Tensor2` or `Tensor4`.

\boldsymbol{C} = \begin{bmatrix}
    C_{11} & C_{22} & C_{33} & C_{12} & C_{23} & C_{13}
\end{bmatrix}^T \longrightarrow
%
\boldsymbol{C} = \begin{bmatrix}
    C_{11} & C_{12} & C_{13} \\
    C_{12} & C_{22} & C_{23} \\
    C_{13} & C_{23} & C_{33}
\end{bmatrix} \qquad

\mathbb{A} = \begin{bmatrix}
    A_{1111} & A_{1122} & A_{1133} & A_{1112} & A_{1123} & A_{1113} \\
    A_{2211} & A_{2222} & A_{2233} & A_{2212} & A_{2223} & A_{2213} \\
     \dots   &  \dots   &  \dots   &  \dots   &  \dots   &  \dots   \\
    A_{1311} & A_{1322} & A_{1333} & A_{1312} & A_{1323} & A_{1313}
\end{bmatrix}

\longrightarrow \begin{bmatrix}
    A_{1111} & A_{1112} & A_{1113} &
    A_{1121} & A_{1122} & A_{1123} &
    A_{1131} & A_{1132} & A_{1133} \\
    %
    A_{1211} & A_{1212} & A_{1213} &
    A_{1221} & A_{1222} & A_{1223} &
    A_{1231} & A_{1232} & A_{1233} \\
    %
    \dots & \dots & \dots & \dots & \dots & \dots & \dots & \dots & \dots \\
    A_{3111} & A_{3112} & A_{3113} &
    A_{3121} & A_{3122} & A_{3123} &
    A_{3131} & A_{3132} & A_{3133}
    %
\end{bmatrix} \qquad

Alias:
- `tensorstore(T)`

### Example

```fortran
type(Tensor2s) :: T
type(Tensor2) :: U

U = astensor(T)
```
