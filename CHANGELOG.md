# Changelog
All notable changes to this project will be documented in this file. The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Changed
- Rename internal matrix square-root from `stretch_2` and `stretch_2s` to `sqrt_2` and `sqrt_2s`. This does not affect the public API which remains unchanged as (matrix) square root `sqrt(T)`.

### Fixed
- Fix the orientation of `rotation_matrix(phi,2)` for a rotation matrix around axis 2. Also fix the docs for `rotation_matrix(phi,1)` and `rotation_matrix(phi,3)`.

## [2.1.0] - 2023-09-25

### Added
- Add a new example for an easy-to-extend Neo-Hookean Abaqus Umat.

### Fixed
- Fix a typo in the basic Neo-Hooke example for Abaqus Umat.
- Disable `implicit none` for the basic Neo-Hooke example for Abaqus Umat (not supported in combination with `INCLUDE 'ABA_PARAM.INC'`).

## [2.0.0] - 2023-07-23

### Added
- Add a warning in the docs that `C**(1/2)` equals to `C**0`. The square root operator must be used instead.

### Changed
- Evaluate the i-th power of the inverse of a tensor for negative exponents in `C**-3`.
- Initialize all tensor components to zero.

### Fixed
- Fix assignments of scalars to tensors.
- Ensure major- and minor-symmetric result in `cdya()`: `C(i,j,k,l) = (A(i,k) B(j,l) + A(i,l) B(j,k) + B(i,k) A(j,l) + B(i,l) A(j,k))/4`.

### Removed
- Remove `ln`, `exp`, `dexp` functions which were based on isotropic tensor function-approximations. This could be misleading if one assumes these are analytic (exact) functions.
- Remove unused internal variables and comments.
- Remove unused `archive_functions.md` from the docs.
- Remove incorrect implementation of `libinnercrossdyadic.f`.

## [1.1.2] - 2023-05-13

### Added
- Add more badges in `README.md` (documentation, latest release).

### Changed
- Better readability of text logo on white background.

## [1.1.1] - 2023-05-13

### Added
- Start keeping a Changelog.
- Add `CITATION.cff` file and remove *How To Cite* section in README.
- Add a text logo and add badges to `README.md`.
