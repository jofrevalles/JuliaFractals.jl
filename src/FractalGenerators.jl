function julia(c::ComplexF64, max_iter::Int = 100)
    return (z0::ComplexF64) -> begin
        z = z0
        for i in 1:max_iter
            if abs(z) > 2
                return (i-1, z, c)
            end
            z = z^2 + c
        end
        return (max_iter, z, c)
    end
end

function mandelbrot(max_iter::Int = 100)
    return (c::ComplexF64) -> begin
        z = 0
        for i in 1:max_iter
            if abs(z) > 2
                return (i-1, z, c)
            end
            z = z^2 + c
        end
        return (max_iter, z, c)
    end
end

function custom_julia(f::Function, max_iter::Int = 100)
    return (z0::ComplexF64) -> begin
        z = z0
        for i in 1:max_iter
            if abs(z) > 2
                return (i-1, z, z0)
            end
            z = f(z)
        end
        return (max_iter, z, z0)
    end
end