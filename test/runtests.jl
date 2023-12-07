using HashCode2014Sol
using BenchmarkTools
using Test

@testset "HashCode2014Sol.jl" begin
    @testset "HW7 (functions.jl)" begin
        c = city()
        rdistance = randomWalkDistance()
        rtime = @belapsed randomWalkDistance()
        println("Random dist=", rdistance)
        println("Random time=", rtime)

        new_soln = optimalWalk(c)
        sdistance = getSolnDistance(new_soln, c)
        stime = @belapsed getSolnDistance(optimalWalk(c), c)
        println("Smart dist=", sdistance)
        println("Smart time=", stime )

        @test sdistance > rdistance
        @test stime < rtime
    end 
    @testset "HW7 (function.jl) part 2" begin
        c = change_duration(city(), 18000)
        rdistance = distance(random_walk(change_duration(city(), 18000)), c)
        rtime = @belapsed distance(random_walk(change_duration(city(), 18000)), c)
        println("Random dist=", rdistance)
        println("Random time=", rtime)

        new_soln = optimalWalk(c)
        sdistance = getSolnDistance(new_soln, c)
        stime = @belapsed getSolnDistance(optimalWalk(c), c)
        println("Smart dist=", sdistance)
        println("Smart time=", stime )
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
