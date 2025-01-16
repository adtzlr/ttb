<p align="center">
  <img src="https://github.com/user-attachments/assets/bcba17f8-77e8-4a1c-b7d4-074b6aef31a7"/>
  <p align="center">Tensor Toolbox for Modern Fortran.</p>
</p>

![GitHub release (latest by date)](https://img.shields.io/github/v/release/adtzlr/ttb?color=green)
![Fortran](https://img.shields.io/badge/modern-fortran-blueviolet)
![License](https://img.shields.io/github/license/adtzlr/ttb)
[![Documentation](https://img.shields.io/badge/docs-html-blue)](https://adtzlr.github.io/ttb)
[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.4077378.svg)](https://doi.org/10.5281/zenodo.4077378)

Commercial FEM software packages offer interfaces (user subroutines written in Fortran) for custom defined user materials like UMAT in [Abaqus](https://www.3ds.com/products-services/simulia/products/abaqus/) or HYPELA2 in [MSC.Marc](http://www.mscsoftware.com/product/marc). In comparison to other scientific programming languages like MATLAB or Python Fortran is not as comfortable to use when dealing with high level programming features of tensor manipulation. On the other hand it's super fast - so why not combine the handy features from MATLAB or Python's NumPy/Scipy with the speed of Fortran? That's the reason why I started working on a simple but effective module called **Tensor Toolbox for Modern Fortran**. I adopted the idea to my needs from [Naumann, C. (2016)](http://nbn-resolving.de/urn:nbn:de:bsz:ch1-qucosa-222075).

The full documentation is available at [https://adtzlr.github.io/ttb](https://adtzlr.github.io/ttb). This project is licensed under the terms of the [MIT license](LICENSE).

## Overview

![deformation](https://github.com/adtzlr/ttb/assets/5793153/14f0f4f3-2b17-4253-ad06-c279a5d75193)

This tensor toolbox provides the following [basic operations for tensor calculus](docs/api/index.md) (all written in double precision `real(kind=8)`):
- Dot Product `C(i,j) = A(i,k) B(k,j)` written as `C = A*B`
- Double Dot Product `C = A(i,j) B(i,j)` written as `C = A**B`
- Dyadic Product `C(i,j,k,l) = A(i,j) B(k,l)` written as `C = A.dya.B`
- Crossed Dyadic Product `C(i,j,k,l) = (A(i,k) B(j,l) + A(i,l) B(j,k) + B(i,k) A(j,l) + B(i,l) A(j,k))/4` written as `C = A.cdya.B`
- Addition `C(i,j) = A(i,j) + B(i,j)` written as `C = A+B`
- Subtraction `C(i,j) = A(i,j) - B(i,j)` written as `C = A-B`
- Multiplication and Division by a Scalar
- Deviatoric Part of Tensor  `dev(C) = C - tr(C)/3 * Eye` written as `dev(C)`
- Transpose and Permutation of indices written as `B = permute(A,1,3,2,4)`
- Rank 2 Identity tensor of input type `Eye = identity2(Eye)` with `C = Eye*C`
- Rank 4 Identity tensor (symmetric variant) of input type `I4 = identity4(Eye)` or `I4 = Eye.cdya.Eye` with `C = I4**C` or `inv(C) = identity4(inv(C))**C`
- Square Root of a positive definite rank 2 tensor `U = sqrt(C)`
- Assigment of a real-valued Scalar to all components of a Tensor `A = 0.0` or `A = 0.d0`
- Assigment of a real-valued Array to a Tensor with matching dimensions `A = B` where B is an Array and A a Tensor
- Assigment of a Tensor in Voigt notation to a Tensor in tensorial notation and vice versa

The idea is to create derived data types for rank 1, rank 2 and rank 4 tensors (and it's symmetric variants). In a next step the operators are defined in a way that Fortran calls different functions based on the input types of the operator: performing a dot product between a vector and a rank 2 tensor or a rank 2 and a rank 2 tensor is a different function. Best of it: you don't have to take care of that.

## Building

The TensorToolBox can be used in several ways. Since moving to free form, slotting it into existing build systems in Fortran legacy applications might cause trouble! Therefore, we have included several new ways to integrate it.

The TTB can be built either with Makefiles, CMake, or the Fortran Package Mangager (FPM). This will ensure maximum compatibility with any build system available. Therefore...

### Makefiles

You can include the dependencies and the build logic into an existing Makefile build system using the existing Makefile provided here as a template. Otherwise, you can make sure this is built first and then your main application, linking statically to yours.

### CMake

Via CMake one can include the building of the TTB into another CMake application via Fetch commands. An example is provided in the examples/ directory.

### FPM

TTB can be built and linked to using the FPM. An example is show in the examples directory/

## Basic Usage
The most basic example on how to use this module is to [download the module](https://github.com/adtzlr/ttb/archive/main.zip), put the 'ttb'-Folder in your working directory and add two lines of code:

```fortran
       include 'ttb/ttb_library.f'

       program script101_ttb
       use Tensor
       implicit none

       ! user code

       end program script101_ttb
```
The `include 'ttb/ttb_library.f'` statement replaces the line with the content of the ttb-module. The first line in a program or subroutine is now a `use Tensor` statement. That's it - now you're ready to go.

## Tensor or Voigt Notation
It depends on your preferences: either you store all tensors in full tensor `dimension(3,3)` or in [voigt](https://en.wikipedia.org/wiki/Voigt_notation) `dimension(6)` notation. The equations remain (nearly) the same. Dot Product, Double Dot Product - every function is implemented in both full tensor and voigt notation. Look for the voigt-comments in an [example](docs/examples/Marc/hypela2_nh_ttb.f) of a user subroutine for MSC.Marc.

## Access Tensor components by Array
Tensor components may be accessed by a conventional array with the name of the tensor variable `T` followed by a percent operator `%` and a type-specific keyword as follows:

- Tensor of rank 1 components as array: `T%a`. i-th component of T: `T%a(i)`
- Tensor of rank 2 components as array: `T%ab`. i,j component of T: `T%ab(i,j)`
- Tensor of rank 4 components as array: `T%abcd`. i,j,k,l component of T: `T%abcd(i,j,k,l)`

- Symmetric Tensor of rank 2 (Voigt) components as array: `T%a6`. i-th component of T: `T%a6(i)`
- Symmetric Tensor of rank 4 (Voigt) components as array: `T%a6b6`. i,j component of T: `T%a6b6(i,j)` (at least minor symmetric)

### Warning: Output as array
It is not possible to access tensor components of a tensor valued function  in a direct way `s = symstore(S1)%a6` - unfortunately this is a limitation of Fortran. To avoid the creation of an extra variable it is possible to use the `asarray(T,i_max[,j_max,k_max,l_max])` function to access tensor components. `i_max,j_max,k_max,l_max` is **not** the single component, instead a slice `T%abcd(1:i_max,1:j_max,1:k_max,1:l_max)` is returned. This can be useful when dealing with mixed formulation or variation principles where the last entry/entries of stress and strain voigt vectors are used for the pressure boundary. To export a full stress tensor `S1` to voigt notation use:

```fortran
       s(1:ndim)        = asarray( voigt(S1), ndim )
       d(1:ndim,1:ndim) = asarray( voigt(C4), ndim, ndim )
```

#### Abaqus Users: Output as abqarray
To export a stress tensor to Abaqus Voigt notation use `asabqarray` which reorders the storage indices to `11,22,33,12,13,23`. This function is available for `Tensor2s` and `Tensor4s` data types.

```fortran
       s(1:ndim) = asabqarray( symstore(S1), ndim )
       ddsdde(1:ndim,1:ndim) = asabqarray( symstore(C4), ndim, ndim )
```

## A note on the Permutation of Indices
The permutation function reorders indices in the given order for a fourth order tensor of data type `Tensor4`. Example: `(i,j,k,l) --> (i,k,j,l)` with `permute(C4,1,3,2,4)`.

## Neo-Hookean Material
With the help of the Tensor module the Second Piola-Kirchhoff stress tensor `S` of a nearly-incompressible Neo-Hookean material model is basically a one-liner:

### Second Piola Kirchhoff Stress Tensor
```fortran
       S = mu*det(C)**(-1./3.)*dev(C)*inv(C)+p*det(C)**(1./2.)*inv(C)
```

While this is of course not the fastest way of calculating the stress tensor it is extremely short and readable. Also the second order tensor variables `S, C` and scalar quantities `mu, p` have to be created at the beginning of the program. A minimal working example for a very simple umat user subroutine can be found in [script_umat.f](docs/examples/script_umat.f). The program is just an example where a subroutine `umat` is called and an output information is printed. It is shown that the tensor toolbox is only used inside the material user subroutine `umat`.

### Material Elasticity Tensor
The isochoric part of the material elasticity tensor `C4_iso` of a nearly-incompressible Neo-Hookean material model is defined and coded as:

```fortran
       C4_iso = det(F)**(-2./3.) * 2./3.* (
     *       tr(C) * identity4(inv(C))
     *     - (Eye.dya.inv(C)) - (inv(C).dya.Eye)
     *     + tr(C)/3. * (inv(C).dya.inv(C)) )
```

### Example of Marc HYPELA2
[Here](docs/examples/Marc/hypela2_nh_ttb.f) you can find an example of a nearly-incompressible version of a Neo-Hookean material for Marc. Updated Lagrange is implemented by a push forward operator of both the stress and the fourth-order elasticity tensor. Herrmann Elements are automatically detected. As HYPELA2 is called twice per iteration the stiffness calculation is only active during stage `lovl == 4`. One of the best things is the super-simple switch from tensor to voigt notation: Change data types of all symmetric tensors and save the right Cauchy-Green deformation tensor in voigt notation. See commented lines for details.

[Download HYPELA2](docs/examples/Marc/hypela2_nh_ttb.f): *Neo-Hooke, Marc, Total Lagrange, Tensor Toolbox*

## Credits
Naumann, C.: [Chemisch-mechanisch gekoppelte Modellierung und Simulation oxidativer Alterungsvorgänge in Gummibauteilen (German)](http://nbn-resolving.de/urn:nbn:de:bsz:ch1-qucosa-222075). PhD thesis. Fakultät für Maschinenbau der Technischen Universität Chemnitz, 2016.

# Changelog
All notable changes to this project will be documented in [this file](CHANGELOG.md). The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).
