using HashCode2014Sol
using BenchmarkTools
using Test

@testset "HashCode2014Sol.jl" begin
    @testset "HW7 (optimized.jl)" begin
        c = city()
        rdistance = random_walk_distance()
        rtime = @belapsed random_walk_distance()

        println("Randomized distance = ", rdistance)
        println("Randomized time = ", rtime)

        new_soln = optimal_walk(c)
        sdistance = distance(new_soln, c)
        stime = @belapsed distance(optimal_walk(city()), city())

        println("Optimized distance = ", sdistance)
        println("Optimized time = ", stime)

        @test sdistance > rdistance
        @test sdistance > 1e6
        @test stime < rtime
    end 

    @testset "routegrid.jl" begin
        c = city()
        for rg in (routegrid(), routegrid(c))  # run tests for each initialization type
            # (1) test that initially routes are one junction
            @test length(rg.routes) == rg.nb_cars  
            @test length(rg.routes[1].streets) == 1 && rg.routes[1].distance == 0 && rg.routes[1].duration == 0
            @test length(last(rg.routes).streets) == 1 && last(rg.routes).distance == 0 && last(rg.routes).duration == 0

            # (2a) test an existing intersection (In default City, streets 109, 1 intersect)
            @test check_junction(rg, 109, 1)[1] == true
            
            # (2b) test a nonexisting intersection
            @test check_junction(rg, 1, 2)[1] == false 

            # (3) test route expansion
            old_len, old_dist, old_dur = length(rg.routes[1].streets), rg.routes[1].distance, rg.routes[1].duration
            old_n_visits = rg.junction_visits[1]
            add_junction_to_route!(rg, 1, 1)
            new_len, new_dist, new_dur = length(rg.routes[1].streets), rg.routes[1].distance, rg.routes[1].duration
            new_n_visits = rg.junction_visits[1]
            @test (new_len - old_len == 1) && (new_dist - old_dist == rg.streets[1].distance) && (new_dur - old_dur == rg.streets[1].duration) && (new_n_visits - old_n_visits == 1)
        end

    end
end
