var documenterSearchIndex = {"docs":
[{"location":"home/#Home","page":"Home","title":"Home","text":"","category":"section"},{"location":"home/","page":"Home","title":"Home","text":"HashCode2014Sol Documentation","category":"page"},{"location":"home/#Quickstart","page":"Home","title":"Quickstart","text":"","category":"section"},{"location":"home/","page":"Home","title":"Home","text":"Pages = [\n    \"tutorial.md\",\n]\nDepth = 3","category":"page"},{"location":"home/#Functions","page":"Home","title":"Functions","text":"","category":"section"},{"location":"home/","page":"Home","title":"Home","text":"Pages = [\"index.md\"]\nDepth = 3","category":"page"},{"location":"home/#Algorithm-description","page":"Home","title":"Algorithm description","text":"","category":"section"},{"location":"home/","page":"Home","title":"Home","text":"Pages = [\n    \"algo.md\",\n]\nDepth = 3","category":"page"},{"location":"algo/#Algorithm-description","page":"Algorithm description","title":"Algorithm description","text":"","category":"section"},{"location":"algo/#optimal_walk","page":"Algorithm description","title":"optimal_walk","text":"","category":"section"},{"location":"algo/","page":"Algorithm description","title":"Algorithm description","text":"optimal_walk(city)","category":"page"},{"location":"algo/","page":"Algorithm description","title":"Algorithm description","text":"Takes a city, and returns an itinerary for each car that reduces repeated travel along visited  streets as much as possible.","category":"page"},{"location":"algo/#Algorithmic-description","page":"Algorithm description","title":"Algorithmic description","text":"","category":"section"},{"location":"algo/","page":"Algorithm description","title":"Algorithm description","text":"TLDR: Modifies random_walk to avoid visiting already visited junctions as much as possible\nTo avoid repeated calculation, gets a matrix of all the streets travelable from each junction, \nSwitches street.endpointA and street.endpointB when bidirectional to put street in the entry of neighbors_streets[endpointB] \nInitialize a dictionary visited_nodes that keeps track of how many times a junction has been visited, (by default: 0 times)\nFor each car:\nGet current_node's travelable streets \nFilter streets by which ones match the total_duration\nFilter further with optimal_neighbor function that picks the least visited neighbor\nIf no applicable streets, move to next car\nAdd the best street's endpointB to current car's itinerary, update visited_nodes and duration\nApply Solution to array of all the cars' itineraries in order\nReturn that solution","category":"page"},{"location":"algo/#upper_limit","page":"Algorithm description","title":"upper_limit","text":"","category":"section"},{"location":"algo/","page":"Algorithm description","title":"Algorithm description","text":"upper_limit(city)","category":"page"},{"location":"algo/","page":"Algorithm description","title":"Algorithm description","text":"Takes a city and gives an approximate upper limit on the distance that can be feasibly traveled by the cars ","category":"page"},{"location":"algo/#Algorithmic-description:","page":"Algorithm description","title":"Algorithmic description:","text":"","category":"section"},{"location":"algo/","page":"Algorithm description","title":"Algorithm description","text":"Assumes that all streets are travelable from one another, and that it is actually one car traveling for a limit total of total_duration times nb_cars seconds. ","category":"page"},{"location":"algo/","page":"Algorithm description","title":"Algorithm description","text":"In that case, we can greedily assume that this one car travels along only the most \"efficient\" streets, or streets that maximize the meter distance traveled per second.","category":"page"},{"location":"algo/","page":"Algorithm description","title":"Algorithm description","text":"We sort the streets by this efficiency definition and make the car travel along the most efficient roads, making sure the running duration does not exceed (total_duration*nb_cars). We keep track of the total distance being traveled.","category":"page"},{"location":"algo/","page":"Algorithm description","title":"Algorithm description","text":"At the end, we return the final distance. ","category":"page"},{"location":"","page":"Functions","title":"Functions","text":"CurrentModule = HashCode2014Sol","category":"page"},{"location":"#HashCode2014Sol-Documentation","page":"Functions","title":"HashCode2014Sol Documentation","text":"","category":"section"},{"location":"","page":"Functions","title":"Functions","text":"Documentation for HashCode2014Sol.","category":"page"},{"location":"","page":"Functions","title":"Functions","text":"","category":"page"},{"location":"","page":"Functions","title":"Functions","text":"Modules = [HashCode2014Sol]","category":"page"},{"location":"#HashCode2014Sol.Problem","page":"Functions","title":"HashCode2014Sol.Problem","text":"Problem\n\nStore a Problem that stores a custom default city from HashCode2014 as problem, only modifying it by the duration given at construction, as well as its most optimal walk solution and the unique distance traveled in this solution in meters.\n\nFields\n\nproblem::City: a problem city description\nsolution:Solution: a solution to the problem based on the optimal_walk algorithm \ndistance::Int: a record, in meters, of the unique distance traveled by the cars in optimal solution\nProblem(duration::Int)\n\nConstructor\n\nReturns a Problem instance about a default city with the given duration (in seconds)\n\n\n\n\n\n","category":"type"},{"location":"#HashCode2014Sol.add_junction_to_route!-Tuple{HashCode2014Sol.RouteGrid, Int64, Int64}","page":"Functions","title":"HashCode2014Sol.add_junction_to_route!","text":"add_junction_to_route!(route_grid, car_id, junction_id)\n\nExpand route of car and increment junction visits\n\n\n\n\n\n","category":"method"},{"location":"#HashCode2014Sol.change_duration-Tuple{HashCode2014.City, Any}","page":"Functions","title":"HashCode2014Sol.change_duration","text":"change_duration(city, total_duration)\n\nCreate a new City with a different total_duration and everything else equal.\n\n\n\n\n\n","category":"method"},{"location":"#HashCode2014Sol.check_junction-Tuple{HashCode2014Sol.RouteGrid, Int64, Int64}","page":"Functions","title":"HashCode2014Sol.check_junction","text":"check_junction(route_grid, street_idx_1, street_idx_2)\n\nCheck if two Streets of the given indices in the RouteGrid intersect at a Junction. If so, return (true, Junction); else, return (false, nothing)\n\n\n\n\n\n","category":"method"},{"location":"#HashCode2014Sol.city-Tuple{}","page":"Functions","title":"HashCode2014Sol.city","text":"city()\n\nReturns default city of type City in HashCode2014 starter \n\n\n\n\n\n","category":"method"},{"location":"#HashCode2014Sol.distance-Tuple{HashCode2014.Solution, HashCode2014.City}","page":"Functions","title":"HashCode2014Sol.distance","text":"distance(solution, city)\n\nFor a city with a feasible solution, returns the unique distance traveled by the cars \n\n\n\n\n\n","category":"method"},{"location":"#HashCode2014Sol.get_junction_connections-Tuple{Vector{HashCode2014.Street}, Vector{HashCode2014.Junction}}","page":"Functions","title":"HashCode2014Sol.get_junction_connections","text":"city: city for which we want to map neighboring streets for for each street\nreturns a vector junction_connections, such that for every junction with index i: every junction index\n    in junction_connections[i] can be traveled to from junction i\n    Goes even more specific that if street in junction_connections[i]:\n            street.endpointA = i\n\n\n\n\n\n","category":"method"},{"location":"#HashCode2014Sol.get_last_junction-Tuple{HashCode2014Sol.RouteGrid, Int64}","page":"Functions","title":"HashCode2014Sol.get_last_junction","text":"get_last_junction(route_grid, car_id)\n\nReturn the last junction that the car has passed in the routegrid.\n\n\n\n\n\n","category":"method"},{"location":"#HashCode2014Sol.optimal_neighbor-Tuple{HashCode2014Sol.RouteGrid, Vector{HashCode2014.Street}}","page":"Functions","title":"HashCode2014Sol.optimal_neighbor","text":"optimal_neighbor(route_grid, query_streets)\n\nPre-requisite: all street.endpointA in querystreets is the same  Parameters:      routegrid: the current RouteGrid in context     querystreets: vector of adjacent streets, assumes for all neighbor in querystreets, neighbor.endpointB is travelable                      from same origin node neighbor.endpointA  Returns the street in querystreets that is least visited, breaks ties by picking left-most entry in querystreets\n\n\n\n\n\n","category":"method"},{"location":"#HashCode2014Sol.optimal_walk-Tuple{HashCode2014.City}","page":"Functions","title":"HashCode2014Sol.optimal_walk","text":"optimal_walk(city)\n\nTakes a city, and returns an itinerary for each car that reduces repeated travel along visited  streets as much as possible.\n\nAlgorithmic description     - Modifies randomwalk to avoid visiting already visited junctions as much as possible     - To avoid repeated calculation, gets a matrix of all the streets travelable from a junction,        switches endpointA and endpointB when bidirectional to put street in the entry of neighborsstreets[endpointB]      - Initialize a dictionary visitednodes that keeps track of how many times a junction has been visited,       by default: 0 times      - For each car:         - Get currentnode's travelable streets          - Filter streets by which ones match the totalduration         - Filter further with optimalneighbor that picks the least visited neighbor         - If no applicable streets, move to next car         - Add the street's endpointB to current car's itinerary, update visited and duration     - Apply Solution(_) to array of all the cars' itineraries in order     - Return that Solution\n\n\n\n\n\n","category":"method"},{"location":"#HashCode2014Sol.random_walk_distance-Tuple{}","page":"Functions","title":"HashCode2014Sol.random_walk_distance","text":"random_walk_distance()\n\nPerforms a random walk on the default city() and returns the unique distance traveled by the cars \n\n\n\n\n\n","category":"method"},{"location":"#HashCode2014Sol.routegrid-Tuple{HashCode2014.City}","page":"Functions","title":"HashCode2014Sol.routegrid","text":"routegrid(city)\n\nCreate a RouteGrid from a specified City. \n\n\n\n\n\n","category":"method"},{"location":"#HashCode2014Sol.routegrid-Tuple{}","page":"Functions","title":"HashCode2014Sol.routegrid","text":"routegrid()\n\nCreate a RouteGrid from the official challenge City. \n\n\n\n\n\n","category":"method"},{"location":"#HashCode2014Sol.upper_limit-Tuple{HashCode2014.City}","page":"Functions","title":"HashCode2014Sol.upper_limit","text":"upper_limit(city)\n\nTakes a city and gives an approximate upper limit on the distance that can be feasibly traveled by the cars \n\n\n\n\n\n","category":"method"},{"location":"tutorial/#Quickstart-tutorial","page":"Quickstart","title":"Quickstart tutorial","text":"","category":"section"}]
}
