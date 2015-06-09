# 005 port simulation to Julia

This is a simulation of the depth-based signal separation as described by
McCarger & Zurk 2013. It is a simple version; the original is found in my
research code, originally written in MATLAB.

This port to [Julia](julialang.org) works with at least v0.3 of Julia.

## To Run It
1. [Install Julia](http://julialang.org/downloads/).
1. Run `Pkg.add("PyPlot")`
1. `cd("path/to/the/file")`
1. `include("simpleDBSS.jl")`
