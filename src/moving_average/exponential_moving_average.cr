module MovingAverage(T)
  # Creates a new `self` containing the exponential moving average (EMA) of each element.
  #
  # The EMA can be defined as the series of weighted values in which the weighting
  # decreases exponentially. The first element of the EMA is the simple moving average,
  # all subsequent elements can be calculated as follows:
  #
  # ```text
  # EMAi = weighting_factor * (Pi - EMAi - 1) + EMAi - 1
  # ```
  #
  # Where
  # - _Pi_ is the value of element i.
  # - *weighting_factor* is a constant between 0 and 1, determined by the _period_.
  #
  # ```
  # [1.0, 2.0, 3.0, 4.0, 5.0].exponential_moving_average(4) # => [2.5, 3.5]
  # ```
  #
  # [Reference](https://en.wikipedia.org/wiki/Moving_average#Exponential_moving_average)
  def exponential_moving_average(period : Int)
    if self.size < period
      msg = "Not enough data to compute exponential moving average with period: #{period}, size: #{self.size}"
      raise InsufficientDataError.new(msg)
    end

    # initial value is SMA
    ema = self[0...period].simple_moving_average(period)
    wf = weighting_factor(period)

    self[period..self.size].each do |xt|
      ema.exponential_moving_average!(period, xt)
    end
    ema
  end

  # Alias for `exponential_moving_average`.
  def ema(period : Int)
    exponential_moving_average(period)
  end

  # Evaluates the exponential moving average of _value_ and appends it to `self`.
  #
  # Useful for updating an existing EMA series quickly. If *previous_ema* is `nil`,
  # the `last` element in the collection will be used.
  #
  # ```
  # ema = [1, 2, 3, 4, 5].exponential_moving_average(4) # => [2, 3]
  # ema.exponential_moving_average!(4, 8)               # => [2, 3, 5]
  # ```
  def exponential_moving_average!(period : Int, value : T, previous_ema = nil)
    if previous_ema.nil? && self.size == 0
      raise InsufficientDataError.new("No previous value to reference for exponential moving average")
    end

    previous_ema ||= self.last
    wf = weighting_factor(period)

    self << ((value - previous_ema) * wf.first / wf.last) + previous_ema
  end

  # Alias for `exponential_moving_average!`.
  def ema!(period : Int, value : T, previous_value = nil)
    exponential_moving_average!(period, value, previous_value)
  end

  # Calculates the weighting factor as a rational for a given _period_.
  #
  # ```
  # factor_as_real_number = weighting_factor(period)[0].to_f64 / weighting_factor(period)[1]
  # ```
  private def weighting_factor(period : Int)
    {2, period + 1}
  end
end
