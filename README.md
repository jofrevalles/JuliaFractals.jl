# JuliaFractals.jl

A library for exploring Julia set fractals using the Julia programming language, because when life gives you Julias, you make Julia set fractals with Julia!

<div style="text-align: center;">
    <img src="./images/example.png" alt="Example images" style="display: inline-block; margin: 0 5px;" />
</div>

## Installation

To install GeneticTextures.jl, open your Julia REPL and type the following commands:

```julia
using Pkg
Pkg.add("https://github.com/jofrevalles/JuliaFractals.jl.git")
```

## Usage
Here's a simple example of how to generate and visualize a Julia set fractal using JuliaFractals.jl:
```julia
using JuliaFractals
using CairoMakie
CairoMakie.activate!(type = "png")

w = h = 1000
style = :smooth
max_it = 100
c = -0.8 + 0.156im

julia_fractal = julia(c, max_iter)
img = generate_image(julia_fractal, style, w, h, (-2.0, 2.0), (-2.0, 2.0), max_iter)

cmap = :algae
f = visualize(img, :makie; cmap=cmap)
```
This example generates a Julia set fractal with the angle coloring method and visualizes it using the Makie backend.

## References

This project was inspired by and uses techniques from the following sources:

1. Mandelbrot, B. B. (1980). The Fractal Geometry of Nature. W. H. Freeman and Company.
2. Peitgen, H.-O., Jürgens, H., & Saupe, D. (1992). Chaos and Fractals: New Frontiers of Science. Springer-Verlag.
3. Sims, K. (1991). Artificial Evolution for Computer Graphics. Computer Graphics, 25(4), 319-328.
4. Sims, K. (1992). Fractal Attraction: A Persistent Illusion. Computer Graphics, 26(2), 148-149.
5. Shiffman, D. (2012). The Nature of Code.
6. Braverman, M. (1999). Fractal Explorer.

