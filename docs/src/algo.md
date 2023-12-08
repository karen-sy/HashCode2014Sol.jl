# Algorithm description
## optimized.jl
### optimal_walk
    optimal_walk(city)

Takes a `city`, and returns an itinerary for each car that reduces repeated travel along visited 
streets as much as possible.

# Algorithmic description
- Modifies `random_walk` to avoid visiting already visited junctions as much as possible
- To avoid repeated calculation, gets a matrix of all the streets travelable from a junction, switches `street.endpointA` and `street.endpointB` when `bidirectional` to put `street` in the entry of `neighbors_streets[endpointB]` 
- Initialize a dictionary `visited_nodes` that keeps track of how many times a junction has been visited, by default: 0 times 
- For each car:
    - Get `current_node`'s travelable `streets` 
    - Filter `streets` by which ones match the `total_duration`
    - Filter further with `optimal_neighbor` that picks the least visited neighbor
    - If no applicable `streets`, move to next car
    - Add the `best_street.endpointB` to current car's itinerary, update `visited_nodes` and `duration`
- Apply `Solution` to array of all the cars' `itineraries` in order
- Return that solution