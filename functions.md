Functions
===

## Dot Product
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
- `Tensor2s` and `Tensor2s`

### Examples
```fortran
T = A*B
T = A.dot.B
```

### Multiplication of a Tensor and a Scalar
```
T(i,j) = A(i,j) * w
```
This special case is implemented within the Dot-Product where every Tensor component is multiplied by the scalar quantity `w`.
As all Tensor data types are forced as `double precision` the scalar value is **always** converted to `double precision`.

## Double-Dot Product
```
T(i,j) = A(i,j,k,l) : B(k,l)
```
The Double-Dot Product performs a double contraction of Tensor components. Available combinations are:
- `Tensor2` and `Tensor2`
- `Tensor2` and `Tensor4`
- `Tensor4` and `Tensor4`
- `Tensor2s` and `Tensor2s`
- `Tensor2s` and `Tensor4s`
- `Tensor4s` and `Tensor4s`

### Examples
```fortran
T = A**B
T = A.ddot.B
```

## Dyadic Product
```
T(i,j,k,l) = A(i,j) B(k,l)
```
The Dyadic Product performs a Tensor multiplication with no contraction. Available combinations are:
- `Tensor1` and `Tensor1`
- `Tensor2` and `Tensor2`
- `Tensor2s` and `Tensor2s`

### Examples
```fortran
T = A.dya.B
```

## Crossed Dyadic Product
```
T(i,j,k,l) = ( A(i,k) B(j,l) + A(i,l) B(j,k) ) / 2
```
The Crossed Dyadic Product performs a Tensor multiplication with no contraction but crossed indices as stated above. Due to compatibility with symmetric tensors this function refers to a symmetric crossed dyadic product. Available combinations are:
- `Tensor2` and `Tensor2`
- `Tensor2s` and `Tensor2s`

### Examples
```fortran
T = A.cdya.B
```

## Addition
```
T(i,j) = A(i,j) + B(i,j)
```
The Addition performs an elementwise addition of Tensor components. Available combinations are:
- `Tensor1` and `Tensor1`
- `Tensor2` and `Tensor2`
- `Tensor2s` and `Tensor2s`
- `Tensor4` and `Tensor4`
- `Tensor4s` and `Tensor4s`

### Examples
```fortran
T = A+B
T = A.add.B
```

## Subtraction
```
T(i,j) = A(i,j) - B(i,j)
```
The Subraction performs an elementwise subtraction of Tensor components. Available combinations are:
- `Tensor1` and `Tensor1`
- `Tensor2` and `Tensor2`
- `Tensor2s` and `Tensor2s`
- `Tensor4` and `Tensor4`
- `Tensor4s` and `Tensor4s`

### Examples
```fortran
T = A-B
T = A.sub.B
```