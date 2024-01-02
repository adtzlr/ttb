---
title: Rotation Matrix
layout: page
nav_order: 3
parent: Functions
grand_parent: API Reference
---

## Rotation Matrix

Rotation Matrix with inputs angle in rad and rotation axis.

| Property   | Value                  |
| ---        | ---                    |
| Result     | Tensor-valued function |
| Data Types | `Tensor2`              |

There are 3 possible cases:

### `rotation_matrix(phi,3)`
$$
\begin{equation}
  \mathbf{R} = \begin{bmatrix} \cos \varphi & -\sin \varphi & 0 \\ \sin \varphi & \cos \varphi & 0 \\ 0 & 0 & 1 \end{bmatrix}
\end{equation}
$$

### `rotation_matrix(phi,2)`
$$
\begin{equation}
  \mathbf{R} = \begin{bmatrix} \cos \varphi & 0 & \sin \varphi\\ 0 & 1 & 0 \\ -\sin \varphi & 0 & \cos \varphi\\ \end{bmatrix}
\end{equation}
$$

### `rotation_matrix(phi,1)`
$$
\begin{equation}
  \mathbf{R} = \begin{bmatrix} 1 & 0 & 0 \\ 0 &\cos \varphi & -\sin \varphi\\ 0 & \sin \varphi & \cos \varphi\\ \end{bmatrix}
\end{equation}
$$

### Example

```fortran
real(kind=8) :: phi
type(Tensor2)  :: R

R = rotation_matrix(phi,1)

```
