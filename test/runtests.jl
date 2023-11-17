using HashCode2014Sol
using BenchmarkTools
using Test

@testset "HashCode2014Sol.jl" begin
    @testset "HW7 (functions.jl)" begin
        random_dist = randomWalkDistance()
        println("Random dist=", random_dist)
        
        c = city()
        soln = smartRandomWalk(c)
        probabilistic_random_dist = getSolnDistance(soln, c)
        println("Smart dist=", probabilistic_random_dist)
        @test random_dist > probabilistic_random_dist   # currently, the random sol is slower but traverses more streets than the probabilistic random sol.
    end

    @testset "routegrid.jl" begin
        c = city()
        rg = routegrid(c)

        # test that initially there are no routes
        @test length(rg.routes) == 0  

        # test an existing intersection (In default City, streets 109, 1 intersect)
        @test check_junction(rg, 109, 1)[1] == true
        
        # test a nonexisting intersection
        @test check_junction(rg, 1, 2)[1] == false 

        # test a nonexisting route 
        @test check_route(rg, 4502, 8400)[1] == false 

        # add a route into RouteGrid (one-street route)
        new_route = route([rg.streets[1]], 4502, 8400)
        add_route!(rg, new_route)
        @test length(rg.routes) == 1

        # delete a route from RouteGrid 
        delete_route!(rg, 4502, 8400)
        @test length(rg.routes) == 0
    end
end
