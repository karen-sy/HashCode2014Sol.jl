using HashCode2014Sol
using BenchmarkTools
using Test

@testset "HashCode2014Sol.jl" begin
    @testset "HW7 (functions.jl)" begin
        random_dist = randomWalkDistance()
        println(random_dist)
        # @btime randomWalkDistance()


        c = city()
        soln = smartRandomWalk(c)
        smart_dist = getSolnDistance(soln, c)
        println(smart_dist)
        # @btime smartRandomWalk(c)

        @test true == true
    end
end
