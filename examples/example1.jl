using JuliaFractals
using CairoMakie
CairoMakie.activate!(type = "png")

c = -0.8 + 0.156im

w = 2000
h = 2000
style = :continuous_potential
max_iter = 100

cmap = :deep

julia_fractal = julia(c, max_iter)
julia_fractal = mandelbrot(max_iter)
img = generate_image(julia_fractal, style, w, h, (-2.0, 2.0), (-2.0, 2.0), max_iter)

# f = visualize(img, :makie, cmap=cmap)
f = visualize(real.(log10.(Complex.(img))), :makie; cmap=cmap)