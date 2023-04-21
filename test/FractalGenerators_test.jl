@testset "FractalGenerators" begin
    # TODO: Add more tests
    @testset "julia" begin
        c = rand(Complex{Float64})
        z = rand(Complex{Float64})
        max_iter = rand(1:100)

        f = julia(c, max_iter)
        @test f isa Function
        @test f(z) isa Tuple{Int64, ComplexF64, ComplexF64}
    end

    @testset "mandelbrot" begin
        c = rand(Complex{Float64})
        max_iter = rand(1:100)

        f = mandelbrot(max_iter)
        @test f isa Function
        @test f(c) isa Tuple{Int64, ComplexF64, ComplexF64}
    end

    @testset "custom_julia" begin
        f = (z) -> z^2 + 1
        z = rand(Complex{Float64})
        max_iter = rand(1:100)

        f = custom_julia(f, max_iter)
        @test f isa Function
        @test f(z) isa Tuple{Int64, ComplexF64, ComplexF64}
    end
end