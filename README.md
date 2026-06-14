# Method of Characteristics Nozzle Design

This repository presents a MATLAB-based implementation of the Method of Characteristics for supersonic nozzle contour generation.

## Overview

The main objective of this project is to study and implement the Method of Characteristics for the design of the divergent section of a supersonic convergent-divergent nozzle. The work focuses on characteristic-line generation, Prandtl-Meyer expansion relations, inverse Mach-number calculation, and nozzle contour construction.

The project was initially introduced during my summer internship at SPACROL and was later improved through the Computational Aerodynamics course, where the mathematical derivations and governing relations were studied in more detail.

## Methods

The project includes the following theoretical and numerical components:

* Prandtl-Meyer function evaluation
* Inverse Mach-number calculation
* Mach angle calculation
* Right-running and left-running characteristic lines
* Compatibility relations along characteristic lines
* Characteristic-grid generation
* Centerline symmetry condition
* Supersonic nozzle contour construction

## Tools Used

* MATLAB
* Computational Aerodynamics
* Compressible Flow Theory
* Numerical Methods

## Project Motivation

This project helped me strengthen my understanding of compressible flow, expansion waves, Mach angle, gas dynamics, and the numerical implementation of aerodynamic design methods.

## Repository Structure

```text
method-of-characteristics-nozzle-design/
│
├── README.md
├── src/
│   ├── main.m
│   ├── prandtl_meyer.m
│   ├── inverse_mach.m
│   ├── mach_angle.m
│   └── characteristic_grid.m
│
├── figures/
│   ├── characteristic_grid.png
│   └── nozzle_contour.png
│
└── docs/
    └── project_summary.pdf
```

## Notes

This repository is intended as an academic and personal engineering portfolio project. The implementation is focused on learning, numerical understanding, and demonstrating the application of the Method of Characteristics to supersonic nozzle design.
