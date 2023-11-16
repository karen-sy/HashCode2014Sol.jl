module HashCode2014Sol
    using HashCode2014
    using BenchmarkTools
    include("functions.jl")

    random_dist = randomWalkDistance()
    println(random_dist)
    @btime randomWalkDistance()


    c = city()
    # c = change_duration(c, 18000)
    soln = smartRandomWalk(c)
    smart_dist = getSolnDistance(soln, c)
    println(smart_dist)
    @btime smartRandomWalk(c)
end