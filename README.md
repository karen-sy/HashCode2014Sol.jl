# HashCode2014Sol

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://karen-sy.github.io/HashCode2014Sol.jl/stable/)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://karen-sy.github.io/HashCode2014Sol.jl/dev/)
[![Build Status](https://github.com/karen-sy/HashCode2014Sol.jl/actions/workflows/CI.yml/badge.svg?branch=master)](https://github.com/karen-sy/HashCode2014Sol.jl/actions/workflows/CI.yml?query=branch%3Amaster)
[![Build Status](https://travis-ci.com/karen-sy/HashCode2014Sol.jl.svg?branch=master)](https://travis-ci.com/karen-sy/HashCode2014Sol.jl)
[![Coverage](https://codecov.io/gh/karen-sy/HashCode2014Sol.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/karen-sy/HashCode2014Sol.jl)
[![Code Style: Blue](https://img.shields.io/badge/code%20style-blue-4495d1.svg)](https://github.com/invenia/BlueStyle)

<<<<<<< HEAD
HashCode2014Sol.jl, written by Karen Chung and Promia Chowdhury, is our attempt at solving the challenge posed by https://gdalle.github.io/IntroJulia/challenge.html. We made ample usage of the starter code that defined preliminary preliminary data structures, and optimized the base solution.

As follows, the problem description is: 

City is defined as a graph with nodes called junctions, connected by edges called streets. Junctions have defined lat. and long. coordinates, while streets have two junctional endpoints a and b; streets are also indicated as bidirectional or not, as well distance and time to travel across the street by car.   

The problem at hand is to optimize Google Streetview collections. We ideally must travel along as many unique streets as possible. We are constrained by various factors:
1. nb_cars = number of cars 
2. total_duration = total duration, in seconds, the nb_cars have to traverse all the streets 
3. starting_junction = the street corner in which all cars start their walks along 

A random_walk solution, in the starter code, randomly, for each car, chooses a viable street to travel across. Our task for the challenge is to reduce computation time, and increase total distance traveled across the city. 

# Tutorial 
## Starting 
Compatibility for Julia 1.8 or above required. Install from Github on terminal. Dependencies are automatically installed, and are as follows:
1. BenchmarkTools
2. [HashCode2014](https://github.com/gdalle/HashCode2014.jl)

## City creations 
Our model city at the moment is Paris. To create a default, call: ``city()``

We may want to fix a solution for smaller constraints. To modify an existing ``city::City`` to a new desired ``total_duration::Int``, call: ``change_duration(city, total_duration)``



A list of all the docstrings

A mathematical description of your algorithms

A critical discussion of their implementation and performance

Ensure your documentation covers all aspects of using your package.

## functions.jl
## routegrid.jl

### Upper bound 
Section the city into different possible paths for each car, such that at each repeating junction, they purposely go on to different undiscovered locations. The time constraint is taken into consideration, where the maximum time taken by a car bounds the overall distance traveled by all cars up to that point.

Realistically, this is an improved solution check due to the feasibility of cars' distances over unique paths in such a short time. 

This gives us an upper bound of 1967444m for 54000 seconds and 1525155m for 18000 seconds 
=======
Project repository for the final project for MIT's [18.C25 Julia: Solving Real-World Problems with Computation](https://github.com/mitmath/JuliaComputation). The project's objective is derived from [Google's HashCode 2014 competition](https://storage.googleapis.com/coding-competitions.appspot.com/HC/2014/hashcode2014_final_task.pdf). 
>>>>>>> c80b4b4cb4653dbaf2d5d7b59dfead7a27e7c66d
