# Algorithm description
## optimal_walk
    optimal_walk(city)

Takes a `city`, and returns an itinerary for each car that reduces repeated travel along visited 
streets as much as possible.

#### Algorithms for Generating a Good Solution
- TLDR: Modifies `random_walk` to avoid visiting already visited junctions as much as possible
- To avoid repeated calculation, gets a matrix of all the streets travelable from each junction, 
    - Switches `street.endpointA` and `street.endpointB` when `bidirectional` to put `street` in the entry of `neighbors_streets[endpointB]` 
- Initialize a dictionary `visited_nodes` that keeps track of how many times a junction has been visited, (by default: 0 times)
- For each car:
    - Get `current_node`'s travelable `streets` 
    - Filter `streets` by which ones match the `total_duration`
    - Filter further with `optimal_neighbor` function that picks the least visited neighbor
    - If no applicable `streets`, move to next car
    - Add the best street's endpointB to current car's itinerary, update `visited_nodes` and `duration`
- Apply `Solution` to array of all the cars' `itineraries` in order
- Return that solution

## Finding an Upper Bound on the Best Objective Value
    upper_limit(city)

Takes a city and gives an approximate upper limit on the distance that can be feasibly traveled by the cars 
#### Algorithmic description:
Assumes that all streets are travelable from one another, and that it is actually one car traveling for a limit
total of `total_duration` times `nb_cars` seconds. 

In that case, we can greedily assume that this one car travels along only the most "efficient" streets, or streets that maximize the meter distance traveled per second.

We sort the streets by this efficiency definition and make the car travel along the most efficient roads, making sure the running duration does not exceed (`total_duration`*`nb_cars`). We keep track of the total distance being traveled.

At the end, we return the final distance. 