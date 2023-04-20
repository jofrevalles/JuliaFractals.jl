function generate_set(method::Symbol = :smooth, width::Int = 800, height::Int = 800, x_range=(-2.0, 2.0), y_range=(-2.0, 2.0), max_iter::Int = 100, trap_radius::Float64 = 0.5; kwargs...)
    if method == :julia
        return julia(width, height, x_range, y_range, max_iter; kwargs...)
    elseif method == :custom_julia
        return custom_julia(width, height, x_range, y_range, max_iter; kwargs...)
    elseif method == :mandelbrot
        return mandelbrot(width, height, x_range, y_range, max_iter; kwargs...)
    elseif method == :smooth
        return smooth(width, height, x_range, y_range, max_iter; kwargs...)
    elseif method == :orbit_trap
        return orbit_trap(width, height, x_range, y_range, max_iter, trap_radius; kwargs...)
    elseif method == :angle_color
        return angle_color(width, height, x_range, y_range, max_iter; kwargs...)
    elseif method == :continuous_potential
        return continuous_potential(width, height, x_range, y_range, max_iter; kwargs...)
    else
        error("Invalid method. Choose from :basic, :smooth, :orbit_trap, :angle_color, or :continuous_potential.")
    end
end

function julia(c::ComplexF64, max_iter::Int = 100)
    return (z0::ComplexF64) -> begin
        z = z0
        for i in 1:max_iter
            if abs(z) > 2
                return i-1
            end
            z = z^2 + c
        end
        return max_iter
    end
end

function custom_julia(f::Function, max_iter::Int = 100)
    return (z0::ComplexF64) -> begin
        z = z0
        for i in 1:max_iter
            if abs(z) > 2
                return i-1
            end
            z = f(z)
        end
        return max_iter
    end
end

function mandelbrot(max_iter::Int = 100)
    return (c::ComplexF64) -> begin
        z = 0
        for i in 1:max_iter
            if abs(z) > 2
                return i-1
            end
            z = z^2 + c
        end
        return max_iter
    end
end

function mandelbrot(width::Int = 800, height::Int = 800, x_range=(-2.0, 2.0), y_range=(-2.0, 2.0), max_iter::Int = 100)
    f = mandelbrot(max_iter)
    img = Array{Float64, 2}(undef, height, width)

    xrange = range(x_range[1], stop=x_range[2], length=width)
    yrange = range(y_range[1], stop=y_range[2], length=height)

    for (i, y) in enumerate(yrange)
        for (j, x) in enumerate(xrange)
            c = complex(x, y)
            img[i, j] = f(c) / max_iter
        end
    end

    return img
end

function julia(width::Int = 800, height::Int = 800, x_range=(-2.0, 2.0), y_range=(-2.0, 2.0), max_iter::Int = 100; c::ComplexF64)
    f = julia(c, max_iter)
    img = Array{Float64, 2}(undef, height, width)

    xrange = range(x_range[1], stop=x_range[2], length=width)
    yrange = range(y_range[1], stop=y_range[2], length=height)

    for (i, y) in enumerate(yrange)
        for (j, x) in enumerate(xrange)
            img[i, j] = f(complex(x, y)) / max_iter
        end
    end

    return img
end

function custom_julia(width::Int = 800, height::Int = 800, x_range=(-2.0, 2.0), y_range=(-2.0, 2.0), max_iter::Int = 100; f::Function)
    f = custom_julia(f, max_iter)
    img = Array{Float64, 2}(undef, height, width)

    xrange = range(x_range[1], stop=x_range[2], length=width)
    yrange = range(y_range[1], stop=y_range[2], length=height)

    for (i, y) in enumerate(yrange)
        for (j, x) in enumerate(xrange)
            img[i, j] = f(complex(x, y)) / max_iter
        end
    end

    return img
end

function smooth(width::Int = 800, height::Int = 800, x_range=(-2.0, 2.0), y_range=(-2.0, 2.0), max_iter::Int = 100; c::ComplexF64)
    img = Array{Float64, 2}(undef, height, width)

    xrange = range(x_range[1], stop=x_range[2], length=width)
    yrange = range(y_range[1], stop=y_range[2], length=height)

    for (i, y) in enumerate(yrange)
        for (j, x) in enumerate(xrange)
            z = complex(x, y)
            k = 1
            while k <= max_iter
                if abs(z) > 2
                    # Apply smooth coloring technique
                    img[i, j] = k - log2(log2(abs(z)))
                    break
                end
                z = z^2 + c
                k += 1
            end
            if k > max_iter
                img[i, j] = max_iter
            end
        end
    end

    return img
end

function orbit_trap(width::Int = 800, height::Int = 800, x_range=(-2.0, 2.0), y_range=(-2.0, 2.0), max_iter::Int = 100, trap_radius::Float64 = 0.5; c::ComplexF64)
    f = julia(c, max_iter)
    img = Array{Float64, 2}(undef, height, width)

    xrange = range(x_range[1], stop=x_range[2], length=width)
    yrange = range(y_range[1], stop=y_range[2], length=height)

    # Define a helper function to compute the color based on the trapping shape.
    function trap_color(z::ComplexF64, trap_radius::Float64)
        dist = abs(z)
        return dist < trap_radius ? dist / trap_radius : 1.0
    end

    for (i, y) in enumerate(yrange)
        for (j, x) in enumerate(xrange)
            z = complex(x, y)
            k = 1
            trapped = false
            while k <= max_iter
                z = z^2 + c
                if abs(z) > 2
                    # If z escapes, stop the iteration.
                    break
                elseif !trapped && abs(z) <= trap_radius
                    # If z falls within the trapping shape, set the color using the orbit trap method and set trapped to true.
                    img[i, j] = trap_color(z, trap_radius)
                    trapped = true
                end
                k += 1
            end
            if !trapped
                # If z doesn't escape and was never trapped, set the color to the maximum value (1.0).
                img[i, j] = 1.0
            end
        end
    end

    return img
end

function angle_color(width::Int = 800, height::Int = 800, x_range=(-2.0, 2.0), y_range=(-2.0, 2.0), max_iter::Int = 100; c::ComplexF64)
    img = Array{Float64, 2}(undef, height, width)

    xrange = range(x_range[1], stop=x_range[2], length=width)
    yrange = range(y_range[1], stop=y_range[2], length=height)

    for (i, y) in enumerate(yrange)
        for (j, x) in enumerate(xrange)
            z = complex(x, y)
            k = 1
            while k <= max_iter
                if abs(z) > 2
                    # Use angle coloring
                    img[i, j] = angle(z) / (2 * pi)
                    break
                end
                z = z^2 + c
                k += 1
            end
            if k > max_iter
                img[i, j] = max_iter
            end
        end
    end

    return img
end

function continuous_potential(width::Int = 800, height::Int = 800, x_range=(-2.0, 2.0), y_range=(-2.0, 2.0), max_iter::Int = 100; c::ComplexF64)
    img = Array{Float64, 2}(undef, height, width)

    xrange = range(x_range[1], stop=x_range[2], length=width)
    yrange = range(y_range[1], stop=y_range[2], length=height)

    for (i, y) in enumerate(yrange)
        for (j, x) in enumerate(xrange)
            z = complex(x, y)
            k = 1
            while k <= max_iter
                if abs(z) > 2
                    # Use continuous potential coloring
                    img[i, j] = 1 + k - log(log(abs(z))) / log(2)
                    break
                end
                z = z^2 + c
                k += 1
            end
            if k > max_iter
                img[i, j] = max_iter
            end
        end
    end

    return img
end
