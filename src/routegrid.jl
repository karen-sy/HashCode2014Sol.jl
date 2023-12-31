"""
    RouteGrid

Store a RouteGrid that encapsulates a City's grid layout and the routes.
This custom type facilitates easy parsing and updating of the information 
associated with calculating and storing routes for traversing a city.

# Fields
- `starting_junction::Int`: junction at which all the cars are located initially
- `nb_cars::Int`: Number of cars traversing the grid 
- `junctions::Vector{Junction}`: list of junctions
- `junction_visits::Dict{Int, Int}`: dict that maps each junction ID to the number of times it has been visited by any car
- `streets::Vector{Street}`: list of streets
- `street_dists::Vector{Int}`` : list of length of each street of `streets`, in meters`
- `routes`::Vector{Route} : list of routes being travelled by each car
"""

import HashCode2014

Base.@kwdef mutable struct Route 
    streets::Vector{Int}
    distance::Int 
    duration::Int
end

Base.@kwdef mutable struct RouteGrid 
    starting_junction::Int 
    junctions::Vector{Junction}
    junction_visits::Dict{Int, Int}
    junction_connections::Dict{Int, Vector{Street}}
    nb_cars::Int
    total_duration::Int
    streets::Vector{Street}
    street_dists::Vector{Int} 
    routes::Vector{Route}
end

#############################
# Initialization ops 
#############################
"""
    get_junction_connections(streets, junctions)

Get the connecting travelable streets for each junction by index 
# Parameter
- `streets::Vector{Street}` - all the streets in our target city 
- `junctions::Vector{Junction}` - all the junctions in our target city 
# Return
- A dictionary `junction_connections` mapping each junction (by its index) to a vector of streets that are travelable from that junction
- Goes even more specific that if a `street` in `streets` is `street.bidirectional`: 
    - `junction_connections[street.endpointB]` contains a new Street instance with the endpoints switched 
"""
function get_junction_connections(streets::Vector{Street}, junctions::Vector{Junction})::Dict{Int, Vector{Street}}
    n_junctions = length(junctions) #number of nodes 
    junction_connections = Dict{Int, Vector{Street}}(zip(1:n_junctions, [Vector{Street}() for _ in 1:n_junctions]))
    #junction_connections[i] represents the corresponding streets that travel them from junction i 
    #to its neighbors 

    for street in streets
        i = street.endpointA
        j = street.endpointB

        push!(junction_connections[i], street)
        if street.bidirectional
            push!(junction_connections[j], Street(j, i, true, street.duration, street.distance))
        end 
    end 
    return junction_connections
end

"""
    routegrid()

Create a RouteGrid from the official challenge City. 
# Parameter
- nothing
# Return
- a default `RouteGrid` instance based on a default `HashCode2014.City` instance
"""
function routegrid()::RouteGrid
    city = HashCode2014.read_city()
    streets = city.streets
    junctions = city.junctions
    starting_junction = city.starting_junction
    nb_cars = city.nb_cars
    street_dists =zeros(length(streets))

    # store Street distances 
    for i=1:length(streets)
        street_dists[i] = streets[i].distance
    end

    # initialize junction visit counts to zeros
    n_junctions = length(junctions)
    keys = 1:n_junctions
    values = zeros(n_junctions)
    junction_visits = Dict{Int, Int}(zip(keys, values))

    # Initialize routes for each car.
    init_route = Route(streets=[starting_junction], distance=0, duration=0)
    init_routes::Vector{Route} = [init_route for _ in 1:nb_cars] 

    # Initialize neighborhood map.
    junction_connections = get_junction_connections(streets, junctions)

    return RouteGrid(total_duration=city.total_duration,
                    starting_junction=starting_junction,
                    nb_cars=nb_cars,
                    junctions=junctions,
                    junction_visits=junction_visits,
                    junction_connections=junction_connections, 
                    streets=streets,
                    street_dists=street_dists, 
                    routes=init_routes)
end

"""
    routegrid(city)

Create a RouteGrid from a specified City. 
# Parameter
- `city::City` - `City` instance we want to derive a `RouteGrid` from
# Return
- new `RouteGrid` instance based on the data of `city` 

"""
function routegrid(city::City)::RouteGrid
    streets = city.streets
    junctions = city.junctions
    starting_junction = city.starting_junction
    nb_cars = city.nb_cars
    street_dists =zeros(length(streets))

    # store Street distances 
    for i=1:length(streets)
        street_dists[i] = streets[i].distance
    end

    # initialize junction visit counts to zeros
    n_junctions = length(junctions)
    keys = 1:n_junctions
    values = zeros(n_junctions)
    junction_visits = Dict{Int, Int}(zip(keys, values))

    # Initialize routes for each car.
    init_route = Route(streets=[starting_junction], distance=0, duration=0)
    init_routes::Vector{Route} = [init_route for _ in 1:nb_cars] 

    # Initialize neighborhood map.
    junction_connections = get_junction_connections(streets, junctions)

    return RouteGrid(total_duration=city.total_duration,
                    starting_junction=starting_junction,
                    nb_cars=nb_cars,
                    junctions=junctions,
                    junction_visits=junction_visits,
                    junction_connections=junction_connections, 
                    streets=streets,
                    street_dists=street_dists, 
                    routes=init_routes)
end

#############################
# Checking Ops 
#############################
"""
    check_junction(route_grid, street_idx_1, street_idx_2)

Check if two given treets in a `RouteGrid` intersect at a junction.
# Parameter
- `route_grid`::RouteGrid - the RouteGrid instance the two streets are part of 
- `street_idx_1::Int` - the first ordered street # 
- `street_idx_2::Int` - the other ordered street # we want to compare the first two 
# Return
- a tuple of form (::Bool, HashCode2014.Junction)
- The first value represents whether the two specified streets intersect at a junction
- The second value representing if yes, at which junction they intersect; is left null if no
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
    get_last_junction(route_grid, car_id)

Get the last junction that the car has passed in the routegrid.
# Parameter
- `route_grid::RouteGrid` - our target `RouteGrid` instance
- `car_id` - the number of the car whose itinerary in `route_grid` we would like to check
Returns index of last junction in `route_grid` visited by car with `car_id`
"""
function get_last_junction(route_grid::RouteGrid, car_id::Int)::Int
    return last(route_grid.routes[car_id].streets)
end


#############################
# Optimal route calculation ops
#############################
"""
    add_junction_to_route!(route_grid, car_id, junction_id)

Expand route of car and increment junction visits
# Parameter
- `route_grid:RouteGrid` - our target `RouteGrid` instance
- `car_id` - the number of the car whose itinerary in `route_grid` we would like to check
# Return
- nothing 
"""
function add_junction_to_route!(route_grid::RouteGrid, car_id::Int, junction_id::Int)
    push!(route_grid.routes[car_id].streets, junction_id) 
    route_grid.routes[car_id].distance +=  route_grid.streets[junction_id].distance
    route_grid.routes[car_id].duration +=  route_grid.streets[junction_id].duration
    route_grid.junction_visits[junction_id] += 1 
end

"""
    optimal_neighbor(route_grid, query_streets)

Pre-requisite: all street.endpointA in query_streets is the same 
# Parameter
- `route_grid:RouteGrid` - the current RouteGrid in context
- `query_streets::Vector{Street}` - vector of adjacent streets
# Return
- the street in query_streets that is least visited, breaks ties by picking left-most entry in query_streets
"""
function optimal_neighbor(route_grid::RouteGrid, query_streets::Vector{Street})::Street
    least_freq_street = query_streets[1]
    least_freq = Inf
    for neighbor in query_streets
        freq = route_grid.junction_visits[neighbor.endpointB]
        if(freq == 0) #not yet visited 
            return neighbor end 
        if( freq < least_freq)
            least_freq = freq
            least_freq_street = neighbor
        end 
    end 
    return least_freq_street
end


