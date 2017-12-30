require "./spec_helper"

# Test data taken from
# http://stockcharts.com/school/doku.php?id=chart_school:technical_indicators:moving_averages
describe "exponential moving average" do
  set = [
    22.2734, 22.194, 22.0847, 22.1741, 22.184,
    22.1344, 22.2337, 22.4323, 22.2436, 22.2933,
    22.1542, 22.3926, 22.3816, 22.6109, 23.3558,
    24.0519, 23.753, 23.8324, 23.9516, 23.6338,
    23.8225, 23.8722, 23.6537, 23.187, 23.0976,
    23.326, 22.6805, 23.0976, 22.4025, 22.1725,
  ].map { |x| BigFloat.new(x) }

  it "should compute the correct result for ema(5) of Array(Float64)" do
    ema = set.exponential_moving_average(5)
    ema.size.should eq 26
    ema.last.should be_close 22.64808419, 0.00001
  end

  it "should compute the correct result for ema(10) of Array(BigFloat)" do
    ema = set.exponential_moving_average(10)
    ema.size.should eq 21
    ema.last.should be_close 22.91556023, 0.00001
  end

  it "should compute the correct result for a single step" do
    sub_set_ema = set[0, set.size - 1].exponential_moving_average(5)
    ema = sub_set_ema.exponential_moving_average!(5, set.last)
    ema.size.should eq 26
    ema.last.should be_close 22.64808419, 0.00001
  end

  it "should compute the correct result when a previous_value is added manually" do
    sub_set_ema = set[0, set.size - 1].exponential_moving_average(5)
    ema = sub_set_ema.exponential_moving_average!(5, set.last, sub_set_ema.last)
    ema.size.should eq 26
    ema.last.should be_close 22.64808419, 0.00001
  end

  it "should compute the correct result for ema of Array(Int32)" do
    last_value = [1, 2, 3, 4, 5].exponential_moving_average(5).last
    last_value.should eq 3
  end

  it "should fail for lack of data" do
    expect_raises(MovingAverage::InsufficientDataError) do
      [1, 2].exponential_moving_average(5)
    end
  end

  it "should fail for lack of previous value" do
    expect_raises(MovingAverage::InsufficientDataError) do
      ([] of Float64).exponential_moving_average!(5, 9.6)
    end
  end
end
