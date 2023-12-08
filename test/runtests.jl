using HashCode2014Sol
using BenchmarkTools
using Test

@testset "HashCode2014Sol.jl" begin
    @testset "HW7 (functions.jl)" begin
        c = city()
        rdistance = random_walk_distance()
        rtime = @belapsed random_walk_distance()

        new_soln = optimal_walk(c)
        sdistance = get_soln_distance(new_soln, c)
        stime = @belapsed get_soln_distance(optimal_walk(city()), city())

        @test sdistance > rdistance
        @test stime < rtime
    end 
    @testset "HW7 (function.jl) part 2" begin
        c = change_duration(city(), 18000)
        rdistance = distance(random_walk(change_duration(city(), 18000)), c)
        rtime = @belapsed distance(random_walk(change_duration(city(), 18000)), change_duration(city(), 18000))

        new_soln = optimal_walk(c)
        sdistance = get_soln_distance(new_soln, c)
        stime = @belapsed get_soln_distance(optimal_walk(change_duration(city(), 18000)), change_duration(city(), 18000))
        
        @test sdistance > rdistance
        @test stime < rtime
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
