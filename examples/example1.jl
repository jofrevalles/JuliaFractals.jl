using JuliaFractals
using CairoMakie
CairoMakie.activate!(type = "png")

c = -0.8 + 0.156im

w = 1000
h = 800
style = :smooth
max_iter = 100
img = generate_set(style, w, h, (-2.0, 2.0), (-2.0, 2.0), max_iter; c=c)

cmap = :algae
f = visualize(real.(log10.(Complex.(img))), :makie; cmap=cmap)
save("real.log10.Complex._julia_set_c($c)_cmap($cmap)_style($style)_maxit($max_it).png", f)
