---
title: API Reference
layout: page
nav_order: 3
has_children: true
---

# Module Function Overview
This module provides several useful assignments, operators and functions for the derived Tensor Data Types.

## A word on Voigt notation
Symmetric 3x3 Tensors may be stored as 6x1 column vectors with the help of the well known [Voigt notation](https://en.wikipedia.org/wiki/Voigt_notation). In an analogous way a transformation may be obtained for at least minor symmetric fourth order tensors (3x3x3x3) which may be stored as a 6x6 matrix. If the fourth order tensor is also major symmetric the reduced 6x6 matrix is also symmetric.

There is no unique method for the storage ordering of tensor components - this toolbox uses the following approach:
`11,22,33,12,23,31`. If you use Abaqus please use `asabqarray` to export tensor components.

To ensure consistency in calculating the virtual work shear terms are treated differently in Voigt notation: "stress"-like tensors or, to be more precisely, contra-variant tensor components are stored "as they are" whereas "strain"-like tensors or, again, co-variant tensor components are stored with **doubled** shear components. As this method is quite complicate for mixed-variant tensors and not really straight-forward to implement inside a whole toolbox this module uses a different "Voigt"-like approach:

All tensors, whether they are "stress"- or "strain"-like are stored with original (**no doubled**) shear components. Instead all dot- and double-dot-products are modified to take virtual work consistency into account. To be more precise, the function `asvoigt` is not really a Voigt storage - it is more a synonym for storing symmetric tensors as vectors and matrices. The user does have to take care of that storage if the strain in a user subroutine is used as an input for a `Tensor2s` data type and divide all shear components by a factor of `2`.

## Assignments
- [General behaviour of data type conversion]({% link api/assignments.md %})

## Operators
- [Dot Product]({% link api/operators.md %})
- [Double Dot Product]({% link api/operators.md %})
- [Dyadic Product]({% link api/operators.md %})
- [Crossed-dyadic Product]({% link api/operators.md %})
- [Division]({% link api/operators.md %})
- [Addition]({% link api/operators.md %})
- [Subtraction]({% link api/operators.md %})

## Scalar-valued functions
- [Trace]({% link api/functions/trace.md %})
- [Determinant]({% link api/functions/determinant.md %})
- [Norm]({% link api/functions/norm.md %})

## Tensor-valued functions
- [Deviator]({% link api/functions/deviator.md %})
- [Unimodular]({% link api/functions/unimodular.md %})
- [Inverse]({% link api/functions/inverse.md %})
- [Transpose]({% link api/functions/transpose.md %})
- [Permute]({% link api/functions/permute.md %})
- [Square root]({% link api/functions/squareroot.md %})
- [Power]({% link api/functions/power.md %})
- [Identity]({% link api/functions/identity.md %})
- [Piola Operation]({% link api/functions/piola.md %})
- [Rotation Matrix]({% link api/functions/rotation.md %})

## Helper Functions
- [As Array]({% link api/functions/asarray.md %})
- [As Abaqus Array]({% link api/functions/asabqarray.md %})
- [As Voigt]({% link api/functions/asvoigt.md %})
- [As Tensor]({% link api/functions/astensor.md %})
- [Import Strain]({% link api/functions/voigtstrain.md %})
