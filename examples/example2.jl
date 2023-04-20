using JuliaFractals
using CairoMakie
CairoMakie.activate!(type = "png")

function fractal_cloud_iteration(a::ComplexF64, b::ComplexF64, c::ComplexF64)
    return (z::ComplexF64) -> exp(c * (z^3 + a * z^2 + b * z))
end

a = complex(-0.5, 0.2)
b = complex(1.3, -0.1)
c = complex(-1.8, 0.156)

w = 1000
h = 800
style = :custom_julia
max_iter = 100
img = generate_set(style, w, h, (-1.0, 1.0), (-1.0, 1.0), max_iter; c = c,f=fractal_cloud_iteration(a, b, c))

cmap = :deep
f = visualize(real.(log10.(Complex.(img))), :makie; cmap=cmap)