This Toolbox is a fortran module which can be used inside modern Fortran compilers. For compatibility reasons to commercial FEM Software packages it is written in _Fixed Format_.

## Installation Requirements
This Toolbox is tested on Windows with both Intel Fortran >2015 (in combination with MSC.Marc) and GFortran >6.3. If you are using Linux it **should** work (but it is untested).

## Download
[Download the module](https://github.com/adtzlr/ttb/archive/main.zip), put the `ttb`-Folder in your working directory and you are ready to dive into comfortable tensor manipulations in Fortran.

## A note on LS-DYNA Users
If you have problems as reported [here] (https://github.com/adtzlr/ttb/issues/10), please add the following line **before** the Tensor-Toolbox include statement. This deactivates tensor with single-precision scalar multiplications and divisions. **Warning**: Now take care to only use double-precision constants in your code!

```fortran
#define NOR4
#include "ttb/ttb_library.F"
```