# Method of Characteristics Nozzle Design

This repository contains a MATLAB-based implementation of the Method of Characteristics (MOC) for supersonic nozzle contour generation.

The project focuses on the construction of a supersonic flow field using characteristic relations, Prandtl-Meyer expansion theory, inverse Mach-number calculation, and point-by-point nozzle contour generation.

## Overview

The Method of Characteristics is used to solve two-dimensional supersonic flow problems by transforming the governing hyperbolic partial differential equations into algebraic and geometric relations along characteristic lines.

In this project, MOC is applied to the design of the divergent section of a supersonic convergent-divergent nozzle. The main goal is to generate the characteristic grid and obtain the corresponding nozzle wall contour using MATLAB.

The theoretical background of the method is documented separately in the `docs` folder.

## Theory Background

A detailed theory and formulation document is included in this repository:

[Method of Characteristics: Theory and Formulation](docs/moc_theory_and_formulation.pdf.pdf)

This document explains the main assumptions, governing equations, characteristic directions, compatibility relations, Prandtl-Meyer function, and the unit processes used in classical MOC nozzle design, including:

- Interior-point process
- Centerline-point process
- Wall-point process
- Characteristic-line intersections
- Nozzle wall contour construction

## Main MATLAB Code

The main script of the project is:

```text
src/Main_MOC.m
````

To run the project, open MATLAB, navigate to the repository folder, and run:

```matlab
run('src/Main_MOC.m')
```

or open `Main_MOC.m` directly from the `src` folder and run it.

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

The MATLAB implementation includes the following main computational steps:

1. Define the initial flow and geometric conditions.
2. Compute the Prandtl-Meyer function and inverse Mach number.
3. Calculate Mach angle and characteristic directions.
4. Generate interior points using intersecting characteristic lines.
5. Apply the centerline symmetry condition.
6. Compute wall points using characteristic relations and wall tangency.
7. Construct the nozzle wall contour from the generated MOC points.

## Tools Used

* MATLAB
* Computational Aerodynamics
* Compressible Flow Theory
* Numerical Methods

## Project Motivation

This project was developed to strengthen the connection between compressible flow theory and numerical implementation. It helped me understand how the Method of Characteristics can be used to construct supersonic flow fields and nozzle contours from governing aerodynamic relations.

The work was initially introduced during my summer internship at SPACROL and was later improved through the Computational Aerodynamics course, where the mathematical derivations and governing relations were studied in more detail.

## Notes

This repository is intended as an academic and personal engineering portfolio project. The implementation is focused on learning, numerical understanding, and demonstrating the application of the Method of Characteristics to supersonic nozzle design.

