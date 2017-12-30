require "./moving_average/*"
require "big"

# The `MovingAverage` mixin provides methods for calculating different moving averages of a collection.
#
# Including types must respond to basic arithmetic operators: `+`, `-`, `*`, and `/`.
#
# `MovingAverage` uses the following methods which must be defined:
# - `new` for creating a new instance of `self`.
# - `size` for determining the size of the collection.
# - `sum` for determining the sum of the collection.
# - `last` for retrieving the last element of the collection.
# - `<<(value : T)` for appending an element to the end of the collection.
# - `[] (range : Range(Int, Int))` for retrieving a section of the collection.
module MovingAverage(T)
  # :nodoc:
  abstract def new
  # :nodoc:
  abstract def size
  # :nodoc:
  abstract def sum
  # :nodoc:
  abstract def last : T
  # :nodoc:
  abstract def <<(value : T)
  # :nodoc:
  abstract def [](range : Range(Int, Int))
end

# Useful when used as a library.
class Array(T)
  include MovingAverage(T)
end
