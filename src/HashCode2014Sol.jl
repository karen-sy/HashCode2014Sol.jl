module HashCode2014Sol
    using HashCode2014


    export city, randomWalkDistance, smartRandomWalk, getSolnDistance   # functions.jl 
    export routegrid, check_junction, check_route, add_route!, delete_route!, replace_route!   # routegrid.jl

    include("functions.jl")
    include("routegrid.jl")
end
