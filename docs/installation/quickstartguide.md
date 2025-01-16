---
title: Quick Start Guide
layout: page
nav_order: 2
parent: Installation
---

## Quick Start Guide
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

Continue to the [Example]({% link examples/index.md %}) section. For a list and detailed information of available functions go [here]({% link api/index.md %}).
