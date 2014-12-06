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

    assert_equal(15, result[:total_calories])

    food_quantities = result[:food_quantities]
    assert_equal(1, food_quantities["Yellow"])
    assert_equal(1, food_quantities["Red"])
    assert_equal(1, food_quantities["Blue"])
    assert_equal(1, food_quantities["Green"])
    assert_equal(nil, food_quantities["Gray"])
  end
end
