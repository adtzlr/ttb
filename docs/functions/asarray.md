## As Array

**Description:** Convert Tensor to Array. This is useful to export results back to the code which is not using the tensor toolbox. This function is very useful because Fortran does not allow access to Tensor components of a function result `s = (dev(S*C)*inv(C))%ab`. Instead this function can be used. If you use Abaqus please use `asabqarray` to export Tensor components.

| Property   | Value                  |
| ---        | ---                    |
| Result     | array                  |
| Data Types | `Tensor2`, `Tensor2s`, `Tensor4`, `Tensor4s`  |

### Example

```fortran
type(Tensor2)  :: S1
type(Tensor4)  :: C4
! type(Tensor2s)  :: S1
! type(Tensor4s)  :: C4

integer :: ndim

real(kind=8), dimension(ndim)      :: s
real(kind=8), dimension(ndim,ndim) :: d

s(1:ndim)         = asarray( voigt(S1), ndim )
d(1:ndim, 1:ndim) = asarray( voigt(C4), ndim, ndim )
```
