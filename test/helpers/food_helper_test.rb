require 'test_helper'

class FoodHelperTest < ActionView::TestCase

  test "should knapsack properly" do 
    result = FoodHelper.determine_ratios(Food.all, 15)

    food_quantities = result[:food_quantities]

    assert_equal(food_quantities["Yellow"], 3)
    assert_equal(food_quantities["Gray"], 3)

    assert_equal(result[:total_calories], 36)
  end
end
