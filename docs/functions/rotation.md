## Rotation Matrix

**Description:** Rotation Matrix with inputs angle in rad and rotation axis.

There are 3 possible cases:
- `rotation_matrix(phi,3)`
<a href="https://www.codecogs.com/eqnedit.php?latex=\mathbf{R}&space;=&space;\begin{bmatrix}&space;\cos&space;\varphi&space;&&space;\sin&space;\varphi&space;&&space;0&space;\\&space;-\sin&space;\varphi&space;&&space;\cos&space;\varphi&space;&&space;0&space;\\&space;0&space;&&space;0&space;&&space;1&space;\end{bmatrix}" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\mathbf{R}&space;=&space;\begin{bmatrix}&space;\cos&space;\varphi&space;&&space;\sin&space;\varphi&space;&&space;0&space;\\&space;-\sin&space;\varphi&space;&&space;\cos&space;\varphi&space;&&space;0&space;\\&space;0&space;&&space;0&space;&&space;1&space;\end{bmatrix}" title="\mathbf{R} = \begin{bmatrix} \cos \varphi & \sin \varphi & 0 \\ -\sin \varphi & \cos \varphi & 0 \\ 0 & 0 & 1 \end{bmatrix}" /></a>

- `rotation_matrix(phi,2)`
<a href="https://www.codecogs.com/eqnedit.php?latex=\mathbf{R}&space;=&space;\begin{bmatrix}&space;\cos&space;\varphi&space;&&space;0&space;&&space;\sin&space;\varphi\\&space;0&space;&&space;1&space;&&space;0&space;\\&space;-\sin&space;\varphi&space;&&space;0&space;&&space;\cos&space;\varphi\\&space;\end{bmatrix}" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\mathbf{R}&space;=&space;\begin{bmatrix}&space;\cos&space;\varphi&space;&&space;0&space;&&space;\sin&space;\varphi\\&space;0&space;&&space;1&space;&&space;0&space;\\&space;-\sin&space;\varphi&space;&&space;0&space;&&space;\cos&space;\varphi\\&space;\end{bmatrix}" title="\mathbf{R} = \begin{bmatrix} \cos \varphi & 0 & \sin \varphi\\ 0 & 1 & 0 \\ -\sin \varphi & 0 & \cos \varphi\\ \end{bmatrix}" /></a>

- `rotation_matrix(phi,1)`
<a href="https://www.codecogs.com/eqnedit.php?latex=\mathbf{R}&space;=&space;\begin{bmatrix}&space;1&space;&&space;0&space;&&space;0&space;\\&space;0&space;&\cos&space;\varphi&space;&&space;\sin&space;\varphi\\&space;0&space;&&space;-\sin&space;\varphi&space;&&space;\cos&space;\varphi\\&space;\end{bmatrix}" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\mathbf{R}&space;=&space;\begin{bmatrix}&space;1&space;&&space;0&space;&&space;0&space;\\&space;0&space;&\cos&space;\varphi&space;&&space;\sin&space;\varphi\\&space;0&space;&&space;-\sin&space;\varphi&space;&&space;\cos&space;\varphi\\&space;\end{bmatrix}" title="\mathbf{R} = \begin{bmatrix} 1 & 0 & 0 \\ 0 &\cos \varphi & \sin \varphi\\ 0 & -\sin \varphi & \cos \varphi\\ \end{bmatrix}" /></a>

| Property   | Value                  |
| ---        | ---                    |
| Result     | Tensor-valued function |
| Data Types | `Tensor2`              |

### Example

```fortran
real(kind=8) :: phi
type(Tensor2)  :: R

R = rotation_matrix(phi,1)

```
