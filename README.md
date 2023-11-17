# HashCode2014Sol

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://karen-sy.github.io/HashCode2014Sol.jl/stable/)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://karen-sy.github.io/HashCode2014Sol.jl/dev/)
[![Build Status](https://github.com/karen-sy/HashCode2014Sol.jl/actions/workflows/CI.yml/badge.svg?branch=master)](https://github.com/karen-sy/HashCode2014Sol.jl/actions/workflows/CI.yml?query=branch%3Amaster)
[![Build Status](https://travis-ci.com/karen-sy/HashCode2014Sol.jl.svg?branch=master)](https://travis-ci.com/karen-sy/HashCode2014Sol.jl)
[![Coverage](https://codecov.io/gh/karen-sy/HashCode2014Sol.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/karen-sy/HashCode2014Sol.jl)
[![Code Style: Blue](https://img.shields.io/badge/code%20style-blue-4495d1.svg)](https://github.com/invenia/BlueStyle)

### Upper bound 
Section the city into different possible paths for each car, such that at each repeating junction, they purposely go on to different undiscovered locations. The time constraint is taken into consideration, where the maximum time taken by a car bounds the overall distance traveled by all cars up to that point.

Realistically, this is an improved solution check due to the feasibility of cars' distances over unique paths in such a short time. 

This gives us an upper bound of 1967444m for 54000 seconds and 1525155m for 18000 seconds 