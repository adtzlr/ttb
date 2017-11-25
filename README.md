# Tensor Toolbox for Modern Fortran (ttb)

Commercial FEM software packages often offer interfaces (user subroutines written in Fortran) for custom defined user materials like UMAT in Abaqus or HYPELA2 in MSC.Marc. Unlike other scientific programming languages like MATLAB or Python Fortran is not as comfortable to use when dealing with high level programming of tensor manipulation. On the other hand it's super fast - so why not combine the handy features from MATLAB or Python's NumPy/Scipy with the speed of Fortran? That's the reason why I started working on a simple but effective module called **Tensor Toolbox for Modern Fortran**.

It provides the following basic operations for tensor calculus:
- Dot Product
- Double Dot Product
- Addition / Subtraction
- Multiplication and Divison by a Scalar
- Transpose and Permutation of indices
- ...

## Usage
The most basic example on how to use this module is to put the 'ttb'-Folder in your working directory and add two lines of code:

```fortran
       include 'ttb/ttb_library.f'

       program script101_ttb
       use Tensor
       implicit none

       ! user code

       end program script101_ttb
```
The `include 'ttb/ttb_library.f'` statement replaces the line with the content of the ttb-module. The first line in a program or subroutine is now a `use Tensor` statement. That's it - you're ready to go.
