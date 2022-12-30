# CBFs

<!--- [![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://dev10110.github.io/CBFs.jl/stable/) --->
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://dev10110.github.io/CBFs.jl/dev/)
[![Build Status](https://github.com/dev10110/CBFs.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/dev10110/CBFs.jl/actions/workflows/CI.yml?query=branch%3Amain)



A Julia library to help construct safety critical controllers using Control Barrier Functions. 

## Installation

Simply 
```
] add https://github.com/dev10110/CBFs.jl
```

## What is a CBF?
For a good overview of CBFs, and how to use them, see this reference:
```
Ames, Aaron D., et al. "Control barrier function based quadratic programs for safety critical systems." IEEE Transactions on Automatic Control 62.8 (2016): 3861-3876.
```

## Quickstart

Simple example of a double integrator trying to not hit a wall that is at ``x_1 = 2.0``, where the control input is the acceleration. Since I'm lazy, I've used `ForwardDiff.jl` to get the gradient of the barrier function.  

```
using LinearAlgebra, ForwardDiff
using CBFs
  
## Define control-affine dynamics
f(x) = [x[2], 0]              # should be a vector
g(x) = [[1.;;], [0.;;]        # should be a matrix (here, 2x1 matrix)

## Define the barrier function
h(x) = -x[2] + (2.0 - x[1])

# construct Lie derivatives Lfh, Lgh
dhdx(x) = ForwardDiff.gradient(h, x)
Lfh(x) = dhdx(x)' * f(x)
Lgh(x) = dhdx(x)' * g(x)

## define the class-K function
# α(r) = 1.0 * r^2            # define a function
α = 1.0                       # or simply define the constant of a linear class-K function


# desired control input
u0 = [1.0]                    # should be a vector 

# state:
x = [1.0, 0.8]
  
# solve for a safe control input:
u_cbf = cbf_qp(u0, h(x), Lfh(x), Lgh(x), α)

# you should get
## u_cbf ≈ [-0.6]
```






