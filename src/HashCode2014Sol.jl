module HashCode2014Sol
    using HashCode2014
    using BenchmarkTools

    export city, randomWalkDistance, smartRandomWalk, getSolnDistance   # functions.jl 
    export routegrid, route, check_junction, check_route, add_route!, delete_route!, replace_route!   # routegrid.jl

    include("functions.jl")
    include("routegrid.jl")
    include("optimized.jl")
end
