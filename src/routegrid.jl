"""
    RouteGrid

Store a RouteGrid that encapsulates a City's grid layout and the routes.
This custom type facilitates easy parsing and updating of the information 
associated with calculating and storing routes for traversing a city.

# Fields
- `starting_junction::Int`: junction at which all the cars are located initially
- `junctions::Vector{Junction}`: list of junctions
- `streets::Vector{Street}`: list of streets
- `street_dists`::Vector{Int} : list of length of each street of `streets`, in meters`
"""

import HashCode2014

Base.@kwdef struct Route 
    streets::Vector{Street}
    start_junc::Int 
    end_junc::Int 
    dist::Int 
    duration::Int
end

Base.@kwdef struct RouteGrid 
    starting_junction::Int 
    junctions::Vector{Junction}
    streets::Vector{Street}
    street_dists::Vector{Int} 
    routes::Dict{Tuple{Int64, Int64},Route}
end

#############################
# Initialization ops 
#############################

"""
    routegrid()

Create a RouteGrid from the official challenge City. 
"""
function routegrid()
    city = HashCode2014.read_city()
    street_dists =zeros(length(city.streets))

    # store Street distances 
    for i=1:length(city.streets)
        street_dists[i] = city.streets[i].distance
    end

    # initially there is no registered route.
    routes = Dict{Tuple{Int64, Int64}, Route}()

    return RouteGrid(starting_junction=city.starting_junction,
                    junctions=city.junctions,
                    streets=city.streets,
                    street_dists=street_dists, 
                    routes=routes)
end

"""
    routegrid(city)

Create a RouteGrid from a specified City. 
"""
function routegrid(city::City)
    street_dists = Vector{Int}(undef, length(city.streets))
    for i=1:length(city.streets)
        street_dists[i] = city.streets[i].distance
    end

    # store Street distances 
    for i=1:length(city.streets)
        street_dists[i] = city.streets[i].distance
    end

    # initially there is no registered route.
    routes = Dict{Tuple{Int64, Int64}, Route}()

    return RouteGrid(starting_junction=city.starting_junction,
                    junctions=city.junctions,
                    streets=city.streets,
                    street_dists=street_dists,
                    routes=routes)
end


"""
    route(streets, start_junc_idx, end_junc_idx)

Create a Route from the in-RouteGrid indices of its start and end junctions
"""
function route(streets::Vector{Street}, start_junc_idx::Int, end_junc_idx::Int)
    total_dist = sum([street.distance for street in streets])
    total_duration = sum([street.duration for street in streets])
    return Route(streets, start_junc_idx, end_junc_idx, total_dist, total_duration)
end

#############################
# Checking Ops 
#############################
"""
    check_junction(route_grid, street_idx_1, street_idx_2)

Check if two Streets of the given indices in the RouteGrid intersect at a Junction.
If so, return (true, Junction); else, return (false, nothing)
"""
function check_junction(route_grid::RouteGrid, street_idx_1::Int, street_idx_2::Int)
    @assert street_idx_1 < length(route_grid.streets) && street_idx_2 < length(route_grid.streets)
    
    street_1::Street = route_grid.streets[street_idx_1]
    street_2::Street = route_grid.streets[street_idx_2]

    eA_1, eB_1 = street_1.endpointA, street_1.endpointB
    eA_2, eB_2 = street_2.endpointA, street_2.endpointB

    # check if endpoints are shared 
    if (eB_1 == eB_2)
        return true, route_grid.junctions[eB_1]
    # check if end of 1 is start of 2, or if end of 2 is start of 1
    elseif (eB_1 == eA_2)
        return true, route_grid.junctions[eB_1]
    elseif (eB_2 == eA_1)
        return true, route_grid.junctions[eB_2]
    # check if startpoints are shared
    elseif (eA_1 == eA_2)
        return true, route_grid.junctions[eA_1]
    end
    
    return false, nothing
end

"""
    check_route(route_grid, junction_idx_start, junction_idx_end)

Check if there exists a Route from two Junctions of the given indices in a RouteGrid.
The first index denotes the start junction, and the second index denotes the end junction.
If so, return (true, Route). Else, return (false, nothing).
"""
function check_route(route_grid::RouteGrid, junction_idx_start::Int, junction_idx_end::Int)
    if haskey(route_grid.routes, (junction_idx_start, junction_idx_end))  
        return (true, route_grid.routes[(junction_idx_start, junction_idx_end)])
    else 
        return (false, nothing)
    end
end


#############################
# Route update ops
#############################

"""
    add_route!(route_grid, route)

Register a new Route to RouteGrid
"""
function add_route!(route_grid::RouteGrid, route::Route)
    print((route.start_junc, route.end_junc))
    route_grid.routes[(route.start_junc, route.end_junc)] = route
end


"""
    delete_route!(route_grid, junc_idx_start, junc_idx_end)

Delete an existing Route between two streets from RouteGrid.
The first index denotes the start street, and the second index denotes the end street.
"""
function delete_route!(route_grid::RouteGrid, junc_idx_start::Int, junc_idx_end::Int)
    @assert haskey(route_grid.routes, (junc_idx_start, junc_idx_end)) "Route to remove does not exist in RouteGrid"
    delete!(route_grid.routes, (junc_idx_start, junc_idx_end))
end


"""
    replace_route!(route_grid, new_route)

Replace an existing Route between two junctions in RouteGrid with a new Route  
"""
function replace_route!(route_grid::RouteGrid, new_route::Route)
    @assert haskey(route_grid.routes, (new_route.start_junc, new_route.end_junc)) "Route between junctions does not already exist in RouteGrid"
    route_grid.routes[(new_route.start_junc, new_route.end_junc)] = new_route
end


