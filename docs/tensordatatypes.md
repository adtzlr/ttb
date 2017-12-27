There are several Tensor Data Types available inside this module:
- `Tensor 1` rank 1 Tensor (Vector)
- `Tensor 2` rank 2 Tensor
- `Tensor 4` rank 4 Tensor
- `Tensor 2s` rank 2 Tensor (symmetric)
- `Tensor 4s` rank 4 Tensor (symmetric)

## Data Type `Tensor1`
This is a rank 1 tensor which represents a vector in 3D cartesian coordinates with length 3.
Access to i-th component: `T%a(i)`

## Data Type `Tensor2`
This is a rank 2 tensor in 3D cartesian coordinates with dimension 3x3.
Access to i,j-component: `T%ab(i,j)`

## Data Type `Tensor4`
This is a rank 4 tensor in 3D cartesian coordinates with dimension 3x3x3x3.
Access to i,j,k,l-component: `T%abcd(i,j,k,l)`

## Data Type `Tensor2s`
This is a symmetric rank 2 tensor in 3D cartesian coordinates which is stored as a vector with length 6. The storage order is `11,22,33,12,23,31`.
Access to i-th component: `T%a6(i)`

## Data Type `Tensor4s`
This is a symmetric rank 4 tensor in 3D cartesian coordinates which is stored as a matrix with dimension 6x6. The storage order for both axis components is `11,22,33,12,23,31`.
Access to i,j-component: `T%a6b6(i,j)`
