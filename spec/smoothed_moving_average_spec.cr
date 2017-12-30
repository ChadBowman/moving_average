require "./spec_helper"

describe "smoothed moving average" do
  set = [
    22.2734, 22.194, 22.0847, 22.1741, 22.184,
    22.1344, 22.2337, 22.4323, 22.2436, 22.2933,
    22.1542, 22.3926, 22.3816, 22.6109, 23.3558,
    24.0519, 23.753, 23.8324, 23.9516, 23.6338,
    23.8225, 23.8722, 23.6537, 23.187, 23.0976,
    23.326, 22.6805, 23.0976, 22.4025, 22.1725,
  ].map { |x| BigFloat.new(x) }

  it "should compute the correct result for smma(5) of Array(BigFloat)" do
    smma = set.smma(5)
    smma.size.should eq 26
    smma.last.should be_close 22.8835, 0.0001
  end

  it "should compute the correct result for smma(10) of Array(BigFloat)" do
    smma = set.smma(10)
    smma.size.should eq 21
    smma.last.should be_close 22.9795, 0.0001
  end

  it "should compute the correct result for smma(5) of Array(Int32)" do
    last_value = [1, 2, 3, 4, 5].smma(5).last
    last_value.should eq 3
  end

  it "should compute the correct result for a single step" do
    sub_set_smma = set[0, set.size - 1].smoothed_moving_average(5)
    smma = sub_set_smma.smoothed_moving_average!(5, set.last)
    smma.size.should eq 26
    smma.last.should be_close 22.8835, 0.0001
  end

  it "should compute the correct result when a previous_value is added manually" do
    sub_set_smma = set[0, set.size - 1].smoothed_moving_average(5)
    smma = sub_set_smma.smoothed_moving_average!(5, set.last, sub_set_smma.last)
    smma.size.should eq 26
    smma.last.should be_close 22.8835, 0.0001
  end

  it "should fail from lack of data" do
    expect_raises(MovingAverage::InsufficientDataError) do
      [1, 2].smma(5)
    end
  end
end
