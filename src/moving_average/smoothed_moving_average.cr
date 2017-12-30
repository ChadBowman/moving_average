module MovingAverage(T)
  # Creates a new `self` containing the smoothed moving average (SMMA) of each element.
  #
  # The SMMA is an exponential weighted average without a fixed period. Each previous datum
  # has some affect to the current SMMA. The first element is the simple moving average,
  # all subsequent elements can be calculated as follows:
  #
  # ```text
  # SMMAi = (Pi - SMMAi - 1) / n + SMMAi - 1
  # ```
  # Where
  # - _Pi_ is the value of element i.
  # - _n_ is the smoothing _period_.
  #
  # ```
  # [1, 2, 3, 4, 5].smoothed_moving_average(4) # => [2, 2]
  # ```
  #
  # [Reference](http://www.20minutetraders.com/learning/moving_averages/smooth-moving-average.php)
  def smoothed_moving_average(period : Int)
    if self.size < period
      raise InsufficientDataError.new("Not enough data to compute smoothed moving average with period: #{period}, size: #{self.size}")
    end

    # initial value is SMA
    smma = self[0...period].simple_moving_average(period)

    self[period..self.size].each do |xt|
      smma.smoothed_moving_average!(period, xt)
    end
    smma
  end

  # Alias for `smoothed_moving_average`.
  def smma(period : Int)
    smoothed_moving_average(period)
  end

  # Evaluates the smoothed moving average of _value_ and appends it to `self`.
  #
  # Useful when updating an existing SMMA series quickly. If *previous_smma* is nil,
  # the `last` element will be used.
  #
  # ```
  # smma = [1, 2, 3, 4, 5].smoothed_moving_average(4) # => [2, 2]
  # smma.smoothed_moving_average!(4, 8)               # => [2, 2, 3]
  # ```
  def smoothed_moving_average!(period : Int, value : T, previous_smma = nil)
    if previous_smma.nil? && self.size == 0
      raise InsufficientDataError.new("No previous value to reference for smoothed moving average")
    end

    previous_smma ||= self.last

    self << ((value - previous_smma) / period) + previous_smma
  end

  # Alias for `smoothed_moving_average!`.
  def smma!(period : Int, value : T, previous_smma = nil)
    smoothed_moving_average!(period, value, previous_smma)
  end
end
