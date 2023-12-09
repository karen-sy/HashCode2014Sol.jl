#### Quickstart tutorial

Running our solution for any given `City` is simple! 


(1) Import the solution module and define the `City` to run the tests on. 
```
using HashCode2014Sol
my_city = city()  # Loads the default HashCode2014 City, based on the map of Paris
```

(2) Run our optimized walk algorithm! 
```
solution = optimal_walk(my_city)
distance = distance(solution, c)  # total distance covered 
```

(3) Use BenchmarkTools to benchmark the performance.
```
using BenchmarkTools
sol_time = @belapsed distance(optimal_walk(city()), city())
```

##### Types for Storing Problem Instances and Solutions
While the user only needs to run `optimal_walk` to retrieve the solution, it is worth noting that the `RouteGrid` type, implemented as a custom Julia type/struct, is crucial in cleanly storing the information during the computation of the solution. 

The `RouteGrid` type contains all the information contained in a `City` (streets, junctions, number of cars,...) *and* information about their interactions. Concretely, `RouteGrid.junction_connections`, `RouteGrid.junction_visits`, and `RouteGrid.routes` (which stores a list of `Route`, a custom type itself!) respectively encode the neighborhood information of junctions, the number of junctions that have been visited, and the current routes that each car has thus far travelled. Consolidating this information in a single type makes our code concise, and provides the right amount of abstraction necessary to perform our optimal walk algorithm efficiently. 