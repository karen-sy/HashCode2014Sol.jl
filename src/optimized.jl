using HashCode2014
include("functions.jl")
include("routegrid.jl")


"""
    optimal_walk(city)

Takes a `city`, and returns an itinerary for each car that reduces repeated travel along visited 
streets as much as possible.

Algorithmic description
    - Modifies random_walk to avoid visiting already visited junctions as much as possible
    - To avoid repeated calculation, gets a matrix of all the streets travelable from a junction, 
      switches endpointA and endpointB when bidirectional to put street in the entry of neighbors_streets[endpointB] 
    - Initialize a dictionary visited_nodes that keeps track of how many times a junction has been visited,
      by default: 0 times 
    - For each car:
        - Get current_node's travelable streets 
        - Filter streets by which ones match the total_duration
        - Filter further with optimal_neighbor that picks the least visited neighbor
        - If no applicable streets, move to next car
        - Add the street's endpointB to current car's itinerary, update visited and duration
    - Apply Solution(_) to array of all the cars' itineraries in order
    - Return that Solution

"""
function optimal_walk(city::City)
    println("Starting optimized walk!")
    route_grid = routegrid(city)
    all_car_routes = route_grid.routes

    for car_id=1:route_grid.nb_cars
        duration = 0
        while true
            current_node = get_last_junction(route_grid, car_id)  

            current_streets::Vector{Street} = [] 
            for street in route_grid.junction_connections[current_node]
                #check for distance constraint 
                if(duration+street.duration <= route_grid.total_duration)
                    push!(current_streets, street)
                end 
            end 
            
            # Terminate if no suitable candidates left
            if(length(current_streets) == 0) break end 
            
            # Else, travel to optimal street 
            best_street = optimal_neighbor(route_grid, current_streets)
            
            # Feasibility check
            @assert HashCode2014.is_street_start(current_node, best_street)

            # Update current exploration and the routegrid 
            duration += best_street.duration
            add_junction_to_route!(route_grid, car_id, best_street.endpointB)            
        end 
    end 
    
    # process final outputs
    sol_streets::Vector{Vector{Int}} = [route.streets for route in all_car_routes]
    return Solution(sol_streets)
end 
