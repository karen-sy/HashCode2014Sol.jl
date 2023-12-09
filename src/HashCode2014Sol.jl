module HashCode2014Sol
    using HashCode2014
    using BenchmarkTools

    export city, random_walk_distance, distance   # functions.jl 
    export optimal_walk # optimized.jl
    export routegrid, route, check_junction, add_junction_to_route!, optimal_neighbor   # routegrid.jl

    include("functions.jl")
    include("routegrid.jl")
    include("optimized.jl")
    include("problem.jl")
end
