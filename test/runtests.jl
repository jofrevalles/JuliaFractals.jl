using Test
using JuliaFractals

@testset "Unit tests" verbose = true begin
    include("FractalGenerators_test.jl")
end
