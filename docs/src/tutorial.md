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
