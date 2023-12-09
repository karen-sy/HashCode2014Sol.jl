var documenterSearchIndex = {"docs":
[{"location":"home/#Welcome-to-the-Documentation-for-HashCode2014Sol.jl","page":"Home","title":"Welcome to the Documentation for HashCode2014Sol.jl","text":"","category":"section"},{"location":"home/","page":"Home","title":"Home","text":"This project is a solution to the JuliaComputation Challenge, which is motivated by Google HashCode 2014 (official task statement). In summary, given a street map of a city, we must find the optimal set of routes that a given number of cars should travel in order to maximize the total coverage of the city's streets.","category":"page"},{"location":"home/#Background","page":"Home","title":"Background","text":"","category":"section"},{"location":"home/","page":"Home","title":"Home","text":"A City is a graph with nodes (Junctions), connected by edges (Streets). Junctions have defined latitude and longitude coordinates, and streets have two junctional endpoints (\"a\" and \"b\"). Streets are also indicated bidirectionality, as well as by distance and time required to travel across the street by car.   ","category":"page"},{"location":"home/","page":"Home","title":"Home","text":"We are constrained by various factors:","category":"page"},{"location":"home/","page":"Home","title":"Home","text":"nb_cars = number of cars \ntotal_duration = total duration, in seconds, the nb_cars have to traverse all the streets \nstarting_junction = the street corner in which all cars start their walks along ","category":"page"},{"location":"home/","page":"Home","title":"Home","text":"A random_walk solution, in the starter code, randomly, for each car, chooses a viable street to travel across. Our task for the challenge is to reduce computation time, and increase total distance traveled across the city. ","category":"page"},{"location":"home/","page":"Home","title":"Home","text":"See the Quickstart page for instructions on running the code, and for notes on our implementation using custom Julia types.","category":"page"},{"location":"home/#Quickstart","page":"Home","title":"Quickstart","text":"","category":"section"},{"location":"home/","page":"Home","title":"Home","text":"Pages = [\n    \"tutorial.md\",\n]\nDepth = 3","category":"page"},{"location":"home/#Functions","page":"Home","title":"Functions","text":"","category":"section"},{"location":"home/","page":"Home","title":"Home","text":"Pages = [\"index.md\"]\nDepth = 3","category":"page"},{"location":"home/#Algorithm-description","page":"Home","title":"Algorithm description","text":"","category":"section"},{"location":"home/","page":"Home","title":"Home","text":"Pages = [\n    \"algo.md\",\n]\nDepth = 3","category":"page"},{"location":"algo/#Algorithm-description","page":"Algorithm description","title":"Algorithm description","text":"","category":"section"},{"location":"algo/#Algorithms-for-Generating-a-Good-Solution","page":"Algorithm description","title":"Algorithms for Generating a Good Solution","text":"","category":"section"},{"location":"algo/","page":"Algorithm description","title":"Algorithm description","text":"optimal_walk(city)","category":"page"},{"location":"algo/","page":"Algorithm description","title":"Algorithm description","text":"Takes a city, and returns an itinerary for each car that reduces repeated travel along visited  streets as much as possible.","category":"page"},{"location":"algo/#Algorithmic-description","page":"Algorithm description","title":"Algorithmic description","text":"","category":"section"},{"location":"algo/","page":"Algorithm description","title":"Algorithm description","text":"TLDR: Modifies random_walk to avoid visiting already visited junctions as much as possible\nTo avoid repeated calculation, gets a matrix of all the streets travelable from each junction, \nSwitches street.endpointA and street.endpointB when bidirectional to put street in the entry of neighbors_streets[endpointB] \nInitialize a dictionary visited_nodes that keeps track of how many times a junction has been visited, (by default: 0 times)\nFor each car:\nGet current_node's travelable streets \nFilter streets by which ones match the total_duration\nFilter further with optimal_neighbor function that picks the least visited neighbor\nIf no applicable streets, move to next car\nAdd the best street's endpointB to current car's itinerary, update visited_nodes and duration\nApply Solution to array of all the cars' itineraries in order\nReturn that solution","category":"page"},{"location":"algo/#Finding-an-Upper-Bound-on-the-Best-Objective-Value","page":"Algorithm description","title":"Finding an Upper Bound on the Best Objective Value","text":"","category":"section"},{"location":"algo/","page":"Algorithm description","title":"Algorithm description","text":"upper_limit(city)","category":"page"},{"location":"algo/","page":"Algorithm description","title":"Algorithm description","text":"Takes a city and gives an approximate upper limit on the distance that can be feasibly traveled by the cars ","category":"page"},{"location":"algo/#Algorithmic-description:","page":"Algorithm description","title":"Algorithmic description:","text":"","category":"section"},{"location":"algo/","page":"Algorithm description","title":"Algorithm description","text":"Assumes that all streets are travelable from one another, and that it is actually one car traveling for a limit total of total_duration times nb_cars seconds. ","category":"page"},{"location":"algo/","page":"Algorithm description","title":"Algorithm description","text":"In that case, we can greedily assume that this one car travels along only the most \"efficient\" streets, or streets that maximize the meter distance traveled per second.","category":"page"},{"location":"algo/","page":"Algorithm description","title":"Algorithm description","text":"We sort the streets by this efficiency definition and make the car travel along the most efficient roads, making sure the running duration does not exceed (total_duration*nb_cars). We keep track of the total distance being traveled.","category":"page"},{"location":"algo/","page":"Algorithm description","title":"Algorithm description","text":"At the end, we return the final distance. ","category":"page"},{"location":"algo/#Results-achieved-with-our-algorithm","page":"Algorithm description","title":"Results achieved with our algorithm","text":"","category":"section"},{"location":"algo/","page":"Algorithm description","title":"Algorithm description","text":"total_duration = 54000 seconds random walk (control): ","category":"page"},{"location":"algo/","page":"Algorithm description","title":"Algorithm description","text":"Distance = 715435 m\nTime = 7.063 s ","category":"page"},{"location":"algo/","page":"Algorithm description","title":"Algorithm description","text":"total_duration = 18000 seconds random walk (control): ","category":"page"},{"location":"algo/","page":"Algorithm description","title":"Algorithm description","text":"Distance = 425783 m\nTime = 2.153 s ","category":"page"},{"location":"algo/","page":"Algorithm description","title":"Algorithm description","text":"","category":"page"},{"location":"algo/","page":"Algorithm description","title":"Algorithm description","text":"total_duration = 54000 seconds optimal walk (our algorithm): ","category":"page"},{"location":"algo/","page":"Algorithm description","title":"Algorithm description","text":"Distance = 1409210 m\nTime = 0.178 s ","category":"page"},{"location":"algo/","page":"Algorithm description","title":"Algorithm description","text":"total_duration = 18000 seconds optimal walk (our algorithm): ","category":"page"},{"location":"algo/","page":"Algorithm description","title":"Algorithm description","text":"Distance = 682037 m\nTime = 0.074 s ","category":"page"},{"location":"","page":"Functions","title":"Functions","text":"CurrentModule = HashCode2014Sol","category":"page"},{"location":"#HashCode2014Sol-Documentation","page":"Functions","title":"HashCode2014Sol Documentation","text":"","category":"section"},{"location":"","page":"Functions","title":"Functions","text":"Documentation for HashCode2014Sol.","category":"page"},{"location":"","page":"Functions","title":"Functions","text":"","category":"page"},{"location":"","page":"Functions","title":"Functions","text":"Modules = [HashCode2014Sol]","category":"page"},{"location":"#HashCode2014Sol.Problem","page":"Functions","title":"HashCode2014Sol.Problem","text":"Problem\n\nStore a Problem that stores a custom default city from HashCode2014 as problem, only modifying it by the duration given at construction, as well as its most optimal walk solution and the unique distance traveled in this solution in meters.\n\nFields\n\nproblem::City: a problem city description\nsolution:Solution: a solution to the problem based on the optimal_walk algorithm \ndistance::Int: a record, in meters, of the unique distance traveled by the cars in optimal solution\nProblem(duration::Int)\n\nParameter\n\nduration::Int - duration in seconds that we want to ascribe to default HashCode2014 city \n\nConstructor\n\nReturns a Problem instance about a default city with the given duration (in seconds)\n\n\n\n\n\n","category":"type"},{"location":"#HashCode2014Sol.add_junction_to_route!-Tuple{HashCode2014Sol.RouteGrid, Int64, Int64}","page":"Functions","title":"HashCode2014Sol.add_junction_to_route!","text":"add_junction_to_route!(route_grid, car_id, junction_id)\n\nExpand route of car and increment junction visits\n\nParameter\n\nroute_grid:RouteGrid - our target RouteGrid instance\ncar_id - the number of the car whose itinerary in route_grid we would like to check\n\nReturns nothing \n\n\n\n\n\n","category":"method"},{"location":"#HashCode2014Sol.change_duration-Tuple{HashCode2014.City, Int64}","page":"Functions","title":"HashCode2014Sol.change_duration","text":"change_duration(city, total_duration)\n\nCreate a new City with a different total_duration and everything else equal.\n\nParameter\n\ncity::City - city whose duration we would like to change \ntotal_duration::Int - the new total_duration (in meters) we would like to change to \n\nReturns a new City instance that changes the total_duration to that specified\n\n\n\n\n\n","category":"method"},{"location":"#HashCode2014Sol.check_junction-Tuple{HashCode2014Sol.RouteGrid, Int64, Int64}","page":"Functions","title":"HashCode2014Sol.check_junction","text":"check_junction(route_grid, street_idx_1, street_idx_2)\n\nCheck if two given treets in a RouteGrid intersect at a junction.\n\nParameter\n\nroute_grid::RouteGrid - the RouteGrid instance the two streets are part of \nstreet_idx_1::Int - the first ordered street # \nstreet_idx_2::Int - the other ordered street # we want to compare the first two \n\nReturn\n\na tuple of form (::Bool, HashCode2014.Junction)\nThe first value represents whether the two specified streets intersect at a junction\nThe second value representing if yes, at which junction they intersect; is left null if no\n\n\n\n\n\n","category":"method"},{"location":"#HashCode2014Sol.city-Tuple{}","page":"Functions","title":"HashCode2014Sol.city","text":"city()\n\nAllows user to create a default HashCode2014 city \n\nParameter: none\n\nReturns default city of type City in HashCode2014 starter \n\n\n\n\n\n","category":"method"},{"location":"#HashCode2014Sol.distance-Tuple{HashCode2014.Solution, HashCode2014.City}","page":"Functions","title":"HashCode2014Sol.distance","text":"distance(solution, city)\n\nFor a city with a feasible solution, find the distance traveled in the solution \n\nParameter\n\nsolution::Solution - a feasibility itinerary solution to the junctions the cars travel to \ncity::City - city whose data values derive the solution\n\nReturns an int representing the unique distance traveled by the cars in the solution in meters\n\n\n\n\n\n","category":"method"},{"location":"#HashCode2014Sol.get_junction_connections-Tuple{Vector{HashCode2014.Street}, Vector{HashCode2014.Junction}}","page":"Functions","title":"HashCode2014Sol.get_junction_connections","text":"get_junction_connections(streets, junctions)\n\nGet the connecting travelable streets for each junction by index \n\nParameter\n\nstreets::Vector{Street} - all the streets in our target city \njunctions::Vector{Junction} - all the junctions in our target city \n\nReturns\n\nA dictionary junction_connections mapping each junction (by its index) to a vector of streets that are travelable from that junction\nGoes even more specific that if a street in streets is street.bidirectional: \njunction_connections[street.endpointB] contains a new Street instance with the endpoints switched \n\n\n\n\n\n","category":"method"},{"location":"#HashCode2014Sol.get_last_junction-Tuple{HashCode2014Sol.RouteGrid, Int64}","page":"Functions","title":"HashCode2014Sol.get_last_junction","text":"get_last_junction(route_grid, car_id)\n\nGet the last junction that the car has passed in the routegrid.\n\nParameter\n\nroute_grid::RouteGrid - our target RouteGrid instance\ncar_id - the number of the car whose itinerary in route_grid we would like to check\n\nReturns index of last junction in route_grid visited by car with car_id\n\n\n\n\n\n","category":"method"},{"location":"#HashCode2014Sol.optimal_neighbor-Tuple{HashCode2014Sol.RouteGrid, Vector{HashCode2014.Street}}","page":"Functions","title":"HashCode2014Sol.optimal_neighbor","text":"optimal_neighbor(route_grid, query_streets)\n\nPre-requisite: all street.endpointA in querystreets is the same  Parameters:      routegrid: the current RouteGrid in context     querystreets: vector of adjacent streets, assumes for all neighbor in querystreets, neighbor.endpointB is travelable                      from same origin node neighbor.endpointA  Returns the street in querystreets that is least visited, breaks ties by picking left-most entry in querystreets\n\n\n\n\n\n","category":"method"},{"location":"#HashCode2014Sol.optimal_walk-Tuple{HashCode2014.City}","page":"Functions","title":"HashCode2014Sol.optimal_walk","text":"optimal_walk(city)\n\nFor a city, get a solution that aims to prioritize undiscovered/infrequent junctions in its cars' traversals\n\nParameter\n\ncity::City - city whose optimal solution we would like to compute \n\nReturns  an itinerary for each car that reduces repeated travel along visited streets as much as possible.\n\nAlgorithmic description in documentation\n\n\n\n\n\n","category":"method"},{"location":"#HashCode2014Sol.random_walk_distance-Tuple{}","page":"Functions","title":"HashCode2014Sol.random_walk_distance","text":"random_walk_distance()\n\nPerforms a random walk on the default city() and gets the distance\n\nParameter: none\n\nReturns an int representing the unique distance traveled by the cars in the solution in meters\n\n\n\n\n\n","category":"method"},{"location":"#HashCode2014Sol.routegrid-Tuple{HashCode2014.City}","page":"Functions","title":"HashCode2014Sol.routegrid","text":"routegrid(city)\n\nCreate a RouteGrid from a specified City. \n\nParameter\n\ncity::City - City instance we want to derive a RouteGrid from\n\nReturns a new RouteGrid instance based on the data of city \n\n\n\n\n\n","category":"method"},{"location":"#HashCode2014Sol.routegrid-Tuple{}","page":"Functions","title":"HashCode2014Sol.routegrid","text":"routegrid()\n\nCreate a RouteGrid from the official challenge City.  Parameter: none Returns a default RouteGrid instance based on a default HashCode2014.City instance\n\n\n\n\n\n","category":"method"},{"location":"#HashCode2014Sol.upper_limit-Tuple{HashCode2014.City}","page":"Functions","title":"HashCode2014Sol.upper_limit","text":"upper_limit(city)\n\nCalculate an approximate upper limit on the distance travelable in city\n\nParameter\n\ncity::City: target City instance \n\nReturns an integer, in meters, representing the upper limit travelable by cars in city\n\nAlgorithm in documentation \n\n\n\n\n\n","category":"method"},{"location":"tutorial/#Tutorial","page":"Quickstart","title":"Tutorial","text":"","category":"section"},{"location":"tutorial/","page":"Quickstart","title":"Quickstart","text":"Running our solution for any given City is simple! ","category":"page"},{"location":"tutorial/","page":"Quickstart","title":"Quickstart","text":"(1) Import the solution module and define the City to run the tests on. ","category":"page"},{"location":"tutorial/","page":"Quickstart","title":"Quickstart","text":"using HashCode2014Sol\nmy_city = city()  # Loads the default HashCode2014 City, based on the map of Paris","category":"page"},{"location":"tutorial/","page":"Quickstart","title":"Quickstart","text":"(2) Run our optimized walk algorithm! ","category":"page"},{"location":"tutorial/","page":"Quickstart","title":"Quickstart","text":"solution = optimal_walk(my_city)\ndistance = distance(solution, c)  # total distance covered ","category":"page"},{"location":"tutorial/","page":"Quickstart","title":"Quickstart","text":"(3) Use BenchmarkTools to benchmark the performance.","category":"page"},{"location":"tutorial/","page":"Quickstart","title":"Quickstart","text":"using BenchmarkTools\nsol_time = @belapsed distance(optimal_walk(city()), city())","category":"page"},{"location":"tutorial/#Types-for-Storing-Problem-Instances-and-Solutions","page":"Quickstart","title":"Types for Storing Problem Instances and Solutions","text":"","category":"section"},{"location":"tutorial/","page":"Quickstart","title":"Quickstart","text":"While the user only needs to run optimal_walk to retrieve the solution, it is worth noting that the RouteGrid type, implemented as a custom Julia type/struct, is crucial in cleanly encapsulating the information during the computation of the solution. ","category":"page"},{"location":"tutorial/","page":"Quickstart","title":"Quickstart","text":"The RouteGrid type contains all the information contained in a City (streets, junctions, number of cars,...) and information about their interactions. Concretely, RouteGrid.junction_connections, RouteGrid.junction_visits, and RouteGrid.routes (which stores a list of Route, a custom type itself!) respectively encode the neighborhood information of junctions, the number of junctions that have been visited, and the current routes that each car has thus far travelled. Consolidating this information in a single type makes our code concise, and provides the right amount of abstraction necessary to perform our optimal walk algorithm efficiently. ","category":"page"}]
}
