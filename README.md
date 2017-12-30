# 📈 Moving Average 📉

A Crystal library for calculating different moving averages.

[![Build Status](https://travis-ci.org/ChadBowman/moving_average.svg?branch=master)](https://travis-ci.org/ChadBowman/moving_average) [![Docs](https://img.shields.io/badge/docs-available-brightgreen.svg)](https://ChadBowman.github.io/moving_average/) [![GitHub release](https://img.shields.io/github/release/ChadBowman/moving_average.svg)](https://github.com/ChadBowman/moving_average/releases)

### _What is a Moving Average?_

A moving average is a calculation used for analysing data to determine trends and momentum.
Commonly used as an indicator in the financial industry to track price changes of a security.


## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  moving_average:
    github: ChadBowman/moving_average
```

In your terminal, install Crystal dependencies with:
```bash
$ shards install
```
or
```bash
$ crystal deps
```

## Usage

Start by requring the `MovingAverage` module.

```crystal
require "moving_average"
```

`MovingAverage` comes included in `Array`, so we can compute the simple moving average (SMA) by simply:

```crystal
a = [1, 2, 3, 4, 5, 6]
a.simple_moving_average(5) # => [3, 4]
```

or

```crystal
a.sma(5) # => [3, 4]
```

Calculating the exponential moving average (EMA) is very similar:

```crystal
a = [1.0, 2.0, 3.0, 4.0, 5.0, 6.0]
ema = a.ema(5) # => [3.0, 4.0]
```

Now say you're maintaining a real-time EMA chart and you want to update your series for a new price:

```crystal
ema.ema!(5, 9.0) # => [3.0, 4.0, 5.666666666666667]
```

A smoothed moving average (SMMA) may be computed in the same way.

-----

Additionally you can include the module in your custom class given that it and the included type respond to the correct methods:

```crystal
require "moving_average"

class MyCustomClass(T)
  include MovingAverage(T)
end

MyCustomClass.new.sma(5) # => new instance of MyCustomClass evaluated for SMA
```

## Contributing

1. Fork it ( https://github.com/ChadBowman/moving_average/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [ChadBowman](https://github.com/ChadBowman) Chad Bowman - creator, maintainer

Inspired by [Brad Cater's moving_averages gem](https://github.com/bradcater/moving_averages)
