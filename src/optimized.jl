using HashCode2014
include("functions.jl")

"""
    optimal_walk(city)

Takes a `city`, and returns an itinerary for each car that reduces repeated travel along visited 
streets as much as possible.

"""
function optimal_walk(city::HashCode2014.City)
    (; total_duration, nb_cars, starting_junction, junctions, streets) = city
    neighbors_streets = get_neighbor_streets(city) #switches endpoints if bidirectional
    #for every neighbor in neighbors_streets[i], neighbor.endpointA = i 

    #frequency of how often we visited every node, default zero 
    N = length(junctions)
    keys = 1:N
    values = [0 for i in 1:N]
    visited_nodes = Dict{Int, Int}(zip(keys, values) )
    #keeps track of which nodes are being traveled by each car: 
    itineraries = [Vector{Int}([starting_junction]) for _ in 1:nb_cars] 

    for car_id=1:nb_cars
        duration = 0
        while true
            current_node = last(itineraries[car_id])

            current_streets::Vector{HashCode2014.Street} = [] 
            for street in neighbors_streets[current_node]
                #check for distance constraint 
                if(duration+street.duration <= total_duration)
                    push!(current_streets, street)
                end 
            end 
            
            if(length(current_streets) == 0) break end #no suitable candidates left 
            best_street = optimal_neighbor(current_streets, visited_nodes) #gets most optimal for distance per time 
            # feasibility check:
            @assert HashCode2014.is_street_start(current_node, best_street)
            # prioritizes undiscovered nodes 

            #update 
            duration += best_street.duration
            push!(itineraries[car_id], best_street.endpointB)
            visited_nodes[best_street.endpointB] += 1 #increments 
            
        end 
    end 
    
    return Solution(itineraries)
end 

"""
    optimal_neighbor(neighbors_streets, visited)

# Pre-requisite
- all `street.endpointA` in `neighbors_streets` is the same 
# Parameters: 
- `neighbors_streets`: vector of adjacent streets, assumes for all `neighbor` in `neighbors_streets`, `neighbor.endpointB` is travelable from same origin node `neighbor.endpointA` 
- `visited`: for all junctions in the corresponding city, a dictionary keeping track of the frequency of how many times each junction was visited (by any car)
# Returns 
The street in `neighbors_streets` that is least visited, breaks ties by picking left-most entry in `neighbors_streets`
"""
function optimal_neighbor(neighbors_streets::Vector{HashCode2014.Street}, visited::Dict{Int, Int})::HashCode2014.Street
    least_freq_street = neighbors_streets[1]
    least_freq = 1000000000
    for neighbor in neighbors_streets
        freq = visited[neighbor.endpointB]
        if(freq == 0) #not yet visited 
            return neighbor end 
        if( freq < least_freq)
            least_freq = freq
            least_freq_street = neighbor
        end 
    end 
    return least_freq_street
end