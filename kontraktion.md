Kontraktion des Einheitstensors 4. Stufe
===

$C_{IJ}=(1^s)_{IJ}^{\ \ \ KL}:C_{KL}$

Die Darstellung erfolgt zunächst in Tensor Notation 3x3x3x3 &rarr; 9x9:

|Tensor Notation|---|---|---|---|---|---|---|---|---|
|-----|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|
||$\frac{\partial}{\partial C_{11}}$|$\frac{\partial}{\partial C_{21}}$|$\frac{\partial}{\partial C_{31}}$|$\frac{\partial}{\partial C_{12}}$|$\frac{\partial}{\partial C_{22}}$|$\frac{\partial}{\partial C_{32}}$|$\frac{\partial}{\partial C_{13}}$|$\frac{\partial}{\partial C_{23}}$|$\frac{\partial}{\partial C_{33}}$|
|$\frac{1}{2} (C_{11}+C_{11})$|$1$|||
|$\frac{1}{2} (C_{21}+C_{12})$||$\frac{1}{2}$||$\frac{1}{2}$|
|$\frac{1}{2} (C_{31}+C_{13})$|||$\frac{1}{2}$||||$\frac{1}{2}$|
|$\frac{1}{2} (C_{12}+C_{21})$||$\frac{1}{2}$||$\frac{1}{2}$|
|$\frac{1}{2} (C_{22}+C_{22})$|||||$1$|
|$\frac{1}{2} (C_{32}+C_{23})$||||||$\frac{1}{2}$||$\frac{1}{2}$|
|$\frac{1}{2} (C_{13}+C_{31})$|||$\frac{1}{2}$||||$\frac{1}{2}$|
|$\frac{1}{2} (C_{23}+C_{32})$||||||$\frac{1}{2}$||$\frac{1}{2}$|
|$\frac{1}{2} (C_{33}+C_{33})$|||||||||$1$|

Zuerst wird die vertikale Kontraktion auf 6 Komponenten ausgeführt. Hierbei wird **NICHT** summiert.

|vertikale Kontraktion 6x9|---|---|---|---|---|---|---|---|---|
|-----|---|---|---|---|---|---|---|---|---|
||$\frac{\partial}{\partial C_{11}}$|$\frac{\partial}{\partial C_{21}}$|$\frac{\partial}{\partial C_{31}}$|$\frac{\partial}{\partial C_{12}}$|$\frac{\partial}{\partial C_{22}}$|$\frac{\partial}{\partial C_{32}}$|$\frac{\partial}{\partial C_{13}}$|$\frac{\partial}{\partial C_{23}}$|$\frac{\partial}{\partial C_{33}}$|
|$C_{11}$|$1$|||
|$\frac{1}{2} (C_{21}+C_{12})$||$\frac{1}{2}$||$\frac{1}{2}$|
|$\frac{1}{2} (C_{31}+C_{13})$|||$\frac{1}{2}$|
|$C_{22}$|||||$1$|
|$\frac{1}{2} (C_{32}+C_{23})$||||||$\frac{1}{2}$||$\frac{1}{2}$|
|$C_{33}$|||||||||$1$|

Anschließend erfolgt die horizontale Kontraktion durch Zusammenfassen der dualen Schubterme.

|horizontale Kontraktion 6x6|---|---|---|---|---|---|
|-----|:-:|:-:|:-:|:-:|:-:|:-:|
||$\frac{\partial}{\partial C_{11}}$|$\frac{\partial}{\partial C_{21}}$+$\frac{\partial}{\partial C_{12}}$|$\frac{\partial}{\partial C_{31}}$+$\frac{\partial}{\partial C_{13}}$|$\frac{\partial}{\partial C_{22}}$|$\frac{\partial}{\partial C_{32}}$+$\frac{\partial}{\partial C_{23}}$|$\frac{\partial}{\partial C_{33}}$|
|$C_{11}$|$1$|||
|$\frac{1}{2} (C_{21}+C_{12})$||$1$|||
|$\frac{1}{2} (C_{31}+C_{13})$|||$1$|||||
|$C_{22}$||||$1$|
|$\frac{1}{2} (C_{32}+C_{23})$|||||$1$||
|$C_{33}$||||||$1$|

Abschließend werden die Matrixeinträge gemäß Voigt-Notation neu angeordnet: 

    (11,22,33,12,23,31)

|neu anordnen 6x6|---|---|---|---|---|---|
|-----|:-:|:-:|:-:|:-:|:-:|:-:|
||$\frac{\partial}{\partial C_{11}}$|$\frac{\partial}{\partial C_{22}}$|$\frac{\partial}{\partial C_{33}}$|$\frac{\partial}{\partial C_{21}}$+$\frac{\partial}{\partial C_{12}}$|$\frac{\partial}{\partial C_{31}}$+$\frac{\partial}{\partial C_{13}}$|$\frac{\partial}{\partial C_{32}}$+$\frac{\partial}{\partial C_{23}}$|
|$C_{11}$|$1$|
|$C_{22}$||$1$|
|$C_{33}$|||$1$|
|$\frac{1}{2} (C_{21}+C_{12})$||||$1$|
|$\frac{1}{2} (C_{32}+C_{23})$|||||$1$|
|$\frac{1}{2} (C_{31}+C_{13})$||||||$1$|

