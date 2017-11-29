Functions
===

# Dot Product
```
T(i,j) = A(i,k) B(k,j)
```
The Dot-Product performs a single contraction of Tensor components. Available combinations are:
- `Tensor1` and `Tensor1`
- `Tensor1` and `Tensor2`
- `Tensor2` and `Tensor1`
- `Tensor2` and `Tensor2`
- `Tensor2` and `Tensor4`
- `Tensor4` and `Tensor4`

## Examples
```fortran
T = A*B
T = A.dot.B
```

## Multiplication of a Tensor and a Scalar
```
T(i,j) = A(i,j) * w
```
This special case is implemented within the Dot-Product where every Tensor component is multiplied by the scalar quantity `w`.
As ass Tensor data types are forced as `double precision` the scalar value is **always** converted to `double precision`.
