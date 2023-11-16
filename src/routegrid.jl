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
    route::Vector{Street}
    start_street::Street 
    end_street::Street 
    dist::Int 
    duration::Int
end

Base.@kwdef struct RouteGrid 
    starting_junction::Int 
    junctions::Vector{Junction}
    streets::Vector{Street}
    street_dists::Vector{Int} 
    routes::Dict{Tuple{Int},{Route}}
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
    street_dists = Vector{Int}(len(city.streets))

    # store Street distances 
    for i=1:len(city.streets)
        street_dists[i] = city.streets[i].distance
    end

    # initially there is no registered route.
    routes = Dict{Tuple{Int},{Route}}()

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
    street_dists = Vector{Int}(len(city.streets))
    for i=1:len(city.streets)
        street_dists[i] = city.streets[i].distance
    end

    # store Street distances 
    for i=1:len(city.streets)
        street_dists[i] = city.streets[i].distance
    end

    # initially there is no registered route.
    routes = Dict{Tuple{Int},{Route}}()

    return RouteGrid(starting_junction=city.starting_junction,
                    junctions=city.junctions,
                    streets=city.streets,
                    street_dists=street_dists,
                    routes=routes)
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
    
    street_1::Street = route_grid.street_dists[street_idx_1]
    street_2::Street = route_grid.street_dists[street_idx_2]

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


#############################
# Route update ops
#############################

"""
    add_route!(route_grid, route)

Register a new Route to RouteGrid
"""
function add_route!(route_grid::RouteGrid, route::Route)
    route_grid[(route.start_street, route.end_street)] = route
end


"""
    delete_route!(route_grid, street_idx_start, street_idx_end)

Delete an existing Route between two streets from RouteGrid.
The first index denotes the start street, and the second index denotes the end street.
"""
function delete_route!(route_grid::RouteGrid, street_idx_start::Int, street_idx_end::Int)
    start_street::Street = route_grid.streets[street_idx_start]
    end_street::Street = route_grid.streets[street_idx_end]
    @assert haskey(route_grid.routes, (start_street, end_street)), "Route to remove does not exist in RouteGrid"
    delete!(route_grid.routes, (start_street, end_street))
end


"""
    replace_route!(route_grid, new_route)

Replace an existing Route between two streets in RouteGrid with a new Route  
"""
function replace_route!(route_grid::RouteGrid, new_route::Route)
    @assert haskey(route_grid.routes, (new_route.start_street, new_route.end_street)), "Route between streets does not already exist in RouteGrid"
    route_grid.routes[(new_route.start_street, new_route.end_street)] = new_route
end


