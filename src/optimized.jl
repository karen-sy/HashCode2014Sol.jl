using HashCode2014
include("functions.jl")
include("routegrid.jl")


"""
    optimal_walk(city)

For a `city`, get a solution that aims to prioritize undiscovered/infrequent junctions in its cars' traversals
# Parameter
- `city::City` - city whose optimal solution we would like to compute 
# Returns  an itinerary for each car that reduces repeated travel along visited streets as much as possible.

Algorithmic description in documentation

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
