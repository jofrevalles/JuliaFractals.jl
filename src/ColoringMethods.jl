function smooth_modifier(k, z, c)
    if abs(z) > 2
        return k - log2(log2(abs(z)))
    else
        return k
    end
end

function orbit_trap_modifier(k, z, trap_radius, max_iter, c)
    trapped = false
    z_trap = z
    for i in 1:k
        z_trap = z_trap^2 + c
        if abs(z_trap) <= trap_radius
            trapped = true
            break
        end
    end

    if trapped
        return abs(z_trap) / trap_radius
    else
        return k / max_iter
    end
end

function angle_modifier(k, z, c)
    if abs(z) > 2
        return angle(z) / (2 * pi)
    else
        return k
    end
end


function continuous_potential_modifier(k, z, c)
    if abs(z) > 2
        return 1 + k - log(log(abs(z))) / log(2)
    else
        return k
    end
end