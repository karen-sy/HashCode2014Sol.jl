using HashCode2014Sol
using BenchmarkTools
using Test

@testset "HashCode2014Sol.jl" begin
    @testset "HW7 (functions.jl)" begin
        random_dist = randomWalkDistance()
        println("Random dist=", random_dist)
        
        c = city()
        soln = smartRandomWalk(c)
        smart_dist = getSolnDistance(soln, c)
        println("Smart dist=", smart_dist)
        # @btime smartRandomWalk(c)

        @test smart_dist > random_dist
    end
end
