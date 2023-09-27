---
title: Operators
layout: page
nav_order: 3
parent: API Reference
---

## Operators Overview

This module uses derived data types where the default operators are overloaded with custom functions. Currently there are the following operators available:

- Addition `A+B`
- Subtraction `A-B`
- Divison by scalar `A/5.`
- Multiplication by scalar `A*5.`
- Dot-Product (single contraction) `A*B`
- Double-Dot-Product (double contraction) `A**B`
- Dyadic Product `A.dya.B`
- Symmetric Crossed-dyadic Product `A.cdya.B` to perform `C(i,j,k,l) = (A(i,k)*B(j,l) + A(i,l)*B(j,k) + B(i,k)*A(j,l) + B(i,l)*A(j,k)) / 4.`

**Warning**: Be sure to use brackets around functions which should be evaluated first because the double contraction has the highest priority as it is replaced by the conventional power function. This leads to wrong results in combination with crossed-dyadic products as they must be evaluated first. Always use brackets like `A**(B.cdya.B)`. Unfortunately this is a limitation of Fortran.
