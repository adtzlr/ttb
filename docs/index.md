# Documentation

...add picture...

<a href="https://www.codecogs.com/eqnedit.php?latex=\mathbf{S}&space;=&space;J^{-2/3}&space;\&space;\text{dev}(\mathbf{\hat&space;S}&space;\mathbf{C})&space;\&space;\mathbf{C}^{-1}&space;&plus;&space;p&space;J&space;\mathbf{C}^{-1}" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\mathbf{S}&space;=&space;J^{-2/3}&space;\&space;\text{dev}(\mathbf{\hat&space;S}&space;\mathbf{C})&space;\&space;\mathbf{C}^{-1}&space;&plus;&space;p&space;J&space;\mathbf{C}^{-1}" title="\mathbf{S} = J^{-2/3} \ \text{dev}(\mathbf{\hat S} \mathbf{C}) \ \mathbf{C}^{-1} + p J \mathbf{C}^{-1}" /></a>

```
S = J**(-2./3.) * dev(Shat*C) * inv(C) + p*J*inv(C)
```

## What is this toolbox about?

Commercial FEM software packages offer interfaces (user subroutines written in Fortran) for custom defined user materials like UMAT in [Abaqus](https://www.3ds.com/products-services/simulia/products/abaqus/) or HYPELA2 in [MSC.Marc](http://www.mscsoftware.com/product/marc). In comparison to other scientific programming languages like MATLAB or Python Fortran is not as comfortable to use when dealing with high level programming features of tensor manipulations. On the other hand it's super fast - so why not combine the handy features from MATLAB or Python's NumPy/Scipy with the speed of Fortran? That's the reason why I started working on a simple but effective module called **Tensor Toolbox for Modern Fortran**. I adopted the idea to my needs from [Naumann, C. (2016)](http://nbn-resolving.de/urn:nbn:de:bsz:ch1-qucosa-222075).

## Documentation
- [Installation](installation.md)
- [Quick Start Guide](quickstartguide.md)
- [Tensor Data Types](tensordatatypes.md)
- [Functions](functions.md)
- [Examples](Examples)

## Credits
Naumann, C.: [Chemisch-mechanisch gekoppelte Modellierung und Simulation oxidativer Alterungsvorgänge in Gummibauteilen (German)](http://nbn-resolving.de/urn:nbn:de:bsz:ch1-qucosa-222075). PhD thesis. Fakultät für Maschinenbau der Technischen Universität Chemnitz, 2016.
