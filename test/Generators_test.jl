@testset "Generators" begin
    # TODO: Add tests
    @testset "generate_set" begin
        c = -0.8 + 0.156im
        w = 2
        h = 2
        style = :julia
        max_iter = 100
        @test generate_set(style, w, h, (-2.0, 2.0), (-2.0, 2.0), max_iter; c=c) isa Matrix
    end
end