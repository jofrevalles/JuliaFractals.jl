module JuliaFractals

include("FractalGenerators.jl")
export julia, mandelbrot, custom_julia

include("ColoringMethods.jl")
include("FractalRendering.jl")
export generate_image

include("Visualizers.jl")
export visualize

end
