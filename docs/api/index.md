---
title: API Reference
layout: page
nav_order: 3
has_children: true
---

## Module Function Overview

This module provides several useful assignments, operators and functions for the derived Tensor Data Types.

### A word on Voigt notation
Symmetric 3x3 Tensors may be stored as 6x1 column vectors with the help of the well known [Voigt notation](https://en.wikipedia.org/wiki/Voigt_notation). In an analogous way a transformation may be obtained for at least minor symmetric fourth order tensors (3x3x3x3) which may be stored as a 6x6 matrix. If the fourth order tensor is also major symmetric the reduced 6x6 matrix is also symmetric.

There is no unique method for the storage ordering of tensor components - this toolbox uses the following approach:
`11,22,33,12,23,31`. If you use Abaqus please use `asabqarray` to export tensor components.

To ensure consistency in calculating the virtual work shear terms are treated differently in Voigt notation: "stress"-like tensors or, to be more precisely, contra-variant tensor components are stored "as they are" whereas "strain"-like tensors or, again, co-variant tensor components are stored with **doubled** shear components. As this method is quite complicate for mixed-variant tensors and not really straight-forward to implement inside a whole toolbox this module uses a different "Voigt"-like approach:

All tensors, whether they are "stress"- or "strain"-like are stored with original (**no doubled**) shear components. Instead all dot- and double-dot-products are modified to take virtual work consistency into account. To be more precise, the function `asvoigt` is not really a Voigt storage - it is more a synonym for storing symmetric tensors as vectors and matrices. The user does have to take care of that storage if the strain in a user subroutine is used as an input for a `Tensor2s` data type and divide all shear components by a factor of `2`.

### Assignments
- [General behaviour of data type conversion]({% link assignments.md %})

### Operators
- [Dot Product]({% link operators/operators_overview.md %})
- [Double Dot Product]({% link operators/operators_overview.md %})
- [Dyadic Product]({% link operators/operators_overview.md %})
- [Crossed-dyadic Product]({% link operators/operators_overview.md %})
- [Division]({% link operators/operators_overview.md %})
- [Addition]({% link operators/operators_overview.md %})
- [Subtraction]({% link operators/operators_overview.md %})

### Scalar-valued functions
- [Trace](functions/trace.md %})
- [Determinant](functions/determinant.md %})
- [Norm](functions/norm.md %})

### Tensor-valued functions
- [Deviator]({% link functions/deviator.md %})
- [Unimodular]({% link functions/unimodular.md %})
- [Inverse]({% link functions/inverse.md %})
- [Transpose]({% link functions/transpose.md %})
- [Permute]({% link functions/permute.md %})
- [Square root]({% link functions/squareroot.md %})
- [Power]({% link functions/power.md %})
- [Identity]({% link functions/identity.md %})
- [Piola Operation]({% link functions/piola.md %})
- [Rotation Matrix]({% link functions/rotation.md %})

### Helper Functions
- [As Array]({% link functions/asarray.md %})
- [As Abaqus Array]({% link functions/asabqarray.md %})
- [As Voigt]({% link functions/asvoigt.md %})
- [As Tensor]({% link functions/astensor.md %})
- [Import Strain]({% link functions/voigtstrain.md %})
