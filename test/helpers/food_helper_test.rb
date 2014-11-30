require 'test_helper'

class FoodHelperTest < ActionView::TestCase

  test "should knapsack properly" do 
    result = FoodHelper.determine_ratios(Food.all, 15)

    assert_equal(result[:total_calories], 15)
  end
end
