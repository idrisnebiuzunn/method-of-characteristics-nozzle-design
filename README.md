# Method of Characteristics Nozzle Design

This repository contains a MATLAB-based implementation of the classical Method of Characteristics (MOC) for supersonic nozzle contour generation.

The project focuses on constructing a two-dimensional planar supersonic flow field using characteristic relations, Prandtl-Meyer expansion theory, inverse Mach-number calculation, and point-by-point nozzle wall generation.

## Overview

The Method of Characteristics is a standard approach for solving two-dimensional supersonic flow problems by transforming the governing hyperbolic partial differential equations into algebraic and geometric relations along characteristic lines.

In this project, MOC is applied to the design of the divergent section of a supersonic convergent-divergent nozzle. The main objective is to generate the characteristic grid and obtain the corresponding minimum-length nozzle wall contour in MATLAB.

This implementation is based on the classical planar formulation of MOC for elementary supersonic nozzle design.

## Theory Background

A detailed theory and formulation document is included in this repository:

[Method of Characteristics: Theory and Formulation](docs/moc_theory_and_formulation.pdf)

This document summarizes the main assumptions, governing equations, characteristic directions, compatibility relations, Prandtl-Meyer function, and the unit processes used in classical MOC nozzle design, including:

- Interior-point process
- Centerline-point process
- Wall-point process
- Characteristic-line intersections
- Nozzle wall contour construction

## Main MATLAB Code

The main script of the project is:

```text
src/Main_MOC.m
```

To run the project, open MATLAB, navigate to the repository folder, and run:

```matlab
run('src/Main_MOC.m')
```

Alternatively, open `Main_MOC.m` directly from the `src` folder and run it inside MATLAB.

## Repository Structure

```text
method-of-characteristics-nozzle-design/
│
├── README.md
│
├── src/
│   ├── Main_MOC.m
│   ├── Area_from_M.m
│   ├── centerline_point.m
│   ├── interior_point.m
│   ├── known_wall_point_from_Cplus.m
│   ├── M_from_Area.m
│   ├── M_from_PM.m
│   ├── machAngle_from_M.m
│   ├── make_point_from_K.m
│   ├── PM_from_M.m
│   ├── wall_point_curve.m
│   └── wall_point_design_from_Cplus.m
│
└── docs/
    └── moc_theory_and_formulation.pdf
```

## Methodology

The MATLAB implementation follows these main steps:

1. Define the initial flow and geometric conditions.
2. Compute the Prandtl-Meyer angle and inverse Mach number.
3. Evaluate Mach angle and characteristic directions.
4. Generate centerline and interior points from intersecting characteristic lines.
5. Apply the wall-point design process using compatibility relations and wall tangency.
6. Construct the nozzle wall contour from the resulting MOC point distribution.

## Notes on the Formulation

This repository uses the classical two-dimensional planar MOC formulation. The generated contour therefore represents a planar minimum-length nozzle solution. If the contour is to be adapted to an axisymmetric nozzle, an additional geometric conversion step is required.

## Tools Used

- MATLAB
- Compressible Flow Theory
- Computational Aerodynamics
- Numerical Methods

## Project Motivation

This project was developed to strengthen the connection between compressible flow theory and numerical implementation. It helped me better understand how the Method of Characteristics can be used to construct supersonic flow fields and nozzle contours directly from aerodynamic governing relations.

The work was first introduced during my summer internship at SPACROL and was later improved through the Computational Aerodynamics course, where the mathematical derivations and governing relations were studied in more detail.

## Disclaimer

This repository is intended as an academic and personal engineering portfolio project. The implementation is focused on learning, numerical understanding, and demonstrating the application of the Method of Characteristics to supersonic nozzle design.
