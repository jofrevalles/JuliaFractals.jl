function generate_image(fractal::Function, method::Symbol = :smooth, width::Int = 800, height::Int = 800, x_range=(-2.0, 2.0), y_range=(-2.0, 2.0), max_iter::Int = 100, trap_radius::Float64 = 0.5; kwargs...)
    coloring_modifier = nothing

    if method == :smooth
        coloring_modifier = smooth_modifier
    elseif method == :orbit_trap
        coloring_modifier = (k, z, c) -> orbit_trap_modifier(k, z, trap_radius, max_iter, c)
    elseif method == :angle_color
        coloring_modifier = angle_modifier
    elseif method == :continuous_potential
        coloring_modifier = continuous_potential_modifier
    else
        error("Invalid method. Choose from :smooth, :orbit_trap, :angle_color, or :continuous_potential.")
    end

    return render_fractal(fractal, width, height, x_range, y_range, coloring_modifier)
end

function render_fractal(f::Function, width::Int, height::Int, x_range=(-2.0, 2.0), y_range=(-2.0, 2.0), coloring_modifier::Union{Nothing, Function} = nothing)
    img = Array{Float64, 2}(undef, height, width)
    xrange = range(x_range[1], stop=x_range[2], length=width)
    yrange = range(y_range[1], stop=y_range[2], length=height)

    for (i, y) in enumerate(yrange)
        for (j, x) in enumerate(xrange)
            z = complex(x, y)
            k, z_final, c = f(z)
            if coloring_modifier !== nothing
                k = coloring_modifier(k, z_final, c)
            end
            img[i, j] = k
        end
    end

    return img
end