require 'test_helper'

class FoodHelperTest < ActionView::TestCase

  test "should knapsack properly" do
    result = FoodHelper.determine_knapsack(Food.all, 15)

    food_quantities = result[:food_quantities]

    assert_equal(3, food_quantities["Yellow"][:quantity])
    assert_equal(3, food_quantities["Gray"][:quantity])

    assert_equal(result[:total_calories], 36)
  end

  test "should knapsack without replacement properly" do
    result = FoodHelper.knapsack_without_replacement(Food.all, 15)

    assert_equal(15, result)
  end
end
