# Changelog
All notable changes to this project will be documented in this file. The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [2.0.0] - 2023-06-23

### Removed
- Remove `ln`, `exp`, `dexp` functions which were based on isotropic tensor function-approximations. This could be misleading if one assumes these are analytic (exact) functions.
- Remove unused internal variables and comments.
- Remove unused `archive_functions.md` from the docs.

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