# Documentation

![Tensor Toolbox for Modern Fortran](images/header.jpg)

## What is this toolbox about?

Commercial FEM software packages offer interfaces (user subroutines written in Fortran) for custom defined user materials like UMAT in [Abaqus](https://www.3ds.com/products-services/simulia/products/abaqus/) or HYPELA2 in [MSC.Marc](http://www.mscsoftware.com/product/marc). In comparison to other scientific programming languages like MATLAB or Python Fortran is not as comfortable to use when dealing with high level programming features of tensor manipulations. On the other hand it's super fast - so why not combine the handy features from MATLAB or Python's NumPy/Scipy with the speed of Fortran? That's the reason why I started working on a simple but effective module called **Tensor Toolbox for Modern Fortran**. I adopted the idea to my needs from [Naumann, C. (2016)](http://nbn-resolving.de/urn:nbn:de:bsz:ch1-qucosa-222075).

## Overview
- [Installation](installation.md)
- [Quick Start Guide](quickstartguide.md)
- [Tensor Data Types](tensordatatypes.md)
- [Functions](functions.md)
- Examples
- Example 1: [St.Venant-Kirchhoff Material](example_stvenantkirchhoff.md)
- Example 2: [Nearly-Incompressible Neo-Hookean Material](example_neohooke.md)
- Example 3: [Neo-Hookean Hyperelasticity with Maxwell-Viscoelasticity](examples/hypela2_nonlinear_viscoelasticity.f)

## Author
Andreas Dutzler, Graz, Austria.
I'm a PhD student at the Insitute of Machine Components and Methods of Development, Area of Structural Durability and Railway Engineering at Graz University of Technology.

## Discussion
For questions I opened a [Thread at PolymerFEM.com](https://polymerfem.com/forum/polymerfem-downloads/user-material-subroutines/25668-discussion-tensor-toolbox-for-modern-fortran-ttb) for discussions regarding this module.

## Credits
Naumann, C.: [Chemisch-mechanisch gekoppelte Modellierung und Simulation oxidativer Alterungsvorgänge in Gummibauteilen (German)](http://nbn-resolving.de/urn:nbn:de:bsz:ch1-qucosa-222075). PhD thesis. Fakultät für Maschinenbau der Technischen Universität Chemnitz, 2016.

## Last updated: 2018/04/06
