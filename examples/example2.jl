using JuliaFractals
using CairoMakie
CairoMakie.activate!(type = "png")

fractal_func(z) = z^3 - 0.1 + 0.65im


a = complex(-0.5, 0.2)
b = complex(1.3, -0.1)
c = complex(-0.45, 0.156)

w = 1000
h = 1000
max_iter = 100
cmap = :deep
style = :angle_color
fractal = custom_julia(fractal_func, max_iter)

img = generate_image(fractal, style, w, h, (-2.0, 2.0), (-2.0, 2.0), max_iter)

f = visualize(img, :makie, cmap=cmap)
# f = visualize(real.(log10.(Complex.(img))), :makie; cmap=cmap)