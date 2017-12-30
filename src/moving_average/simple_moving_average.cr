module MovingAverage(T)
  # Creates a new `self` containing the simple moving average (SMA) of each element.
  #
  # The SMA of a single element can be defined as the mean of previous _n_ data:
  #
  # ```text
  # SMAi = (Pi + Pi-1 + ... + Pi-(n-1)) / n
  # ```
  #
  # Where
  # - _Pi_ is the value of element i.
  # - _n_ corresponds to the _period_ and is the number of datum to consider.
  #
  # ```
  # [1, 2, 3, 4, 5].simple_moving_average(4) # => [2, 3]
  # ```
  #
  # [Reference](https://en.wikipedia.org/wiki/Moving_average#Simple_moving_average)
  def simple_moving_average(period : Int)
    if self.size < period
      raise InsufficientDataError.new("Not enough data to compute simple moving average with period: #{period}, size: #{self.size}")
    end

    sma = typeof(self).new

    (self.size - period + 1).times do |first|
      chunk = self[first...(first + period)]
      sma << chunk.sum / chunk.size
    end
    sma
  end

  # Alias for `simple_moving_average`.
  def sma(period : Int)
    simple_moving_average(period)
  end
end
