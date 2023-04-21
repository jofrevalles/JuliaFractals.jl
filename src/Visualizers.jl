using Makie
using Plots
using ColorSchemes

function visualize(img::Array{Float64, 2}, backend::Symbol = :makie; cmap=:viridis)
    if backend == :makie
        return makie_visualize(img, cmap=cmap)
    elseif backend == :plots
        return plots_visualize(img, cmap=cmap)
    else
        error("Invalid backend. Choose either :makie or :plots.")
    end
end

function plots_visualize(img::Array{Float64, 2}; cmap=:viridis)
    img_normalized = (img .- minimum(img)) ./ (maximum(img) - minimum(img))
    return Plots.heatmap(img_normalized, color=cgrad(cmap), legend=false, axis=false, border=:none, size=(800, 800), dpi=100, aspect_ratio=:equal)
end

function makie_visualize(img::Array{Float64, 2}; cmap=:viridis)
    cmap_func = colorschemes[cmap]
    cmap = to_colormap(cmap_func)

    img_normalized = (img .- minimum(img)) ./ (maximum(img) - minimum(img))


    f = Figure(resolution=(size(img, 2), size(img, 1)))
    ax, hm = Makie.heatmap(f[1, 1], (img_normalized), colormap=cmap)

    # scene = Makie.heatmap(img_normalized, colormap=cmap)
    # Makie.display(scene)

    hidedecorations!(ax)
    hidespines!(ax)

    display(f)
    return f
end
