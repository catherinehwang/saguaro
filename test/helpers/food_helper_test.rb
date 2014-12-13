require 'test_helper'

class FoodHelperTest < ActionView::TestCase

  test "should knapsack properly" do
    result = FoodHelper.knapsack_with_replacement(Food.where(source: "box"), 15)

    food_quantities = result[:food_quantities]

    assert_equal(3, food_quantities["Yellow"][:quantity])
    assert_equal(3, food_quantities["Gray"][:quantity])

    assert_equal(result[:total_calories], 36)
  end

  test "should knapsack with replacement properly" do
    result = FoodHelper.knapsack_with_replacement(Food.where(source: "museum"), 10)

    food_quantities = result[:food_quantities]

    assert_equal(48, result[:total_calories])
    assert_equal(1, food_quantities["One"][:quantity])
    assert_equal(2, food_quantities["Four"][:quantity])
  end

  test "should knapsack without replacement properly" do
    result = FoodHelper.knapsack_without_replacement(Food.where(source: "box"), 15)

    names = result.map(&:name)

    assert_equal(4, names.length)
    assert_equal(true, names.include?("Yellow"))
    assert_equal(true, names.include?("Red"))
    assert_equal(true, names.include?("Blue"))
    assert_equal(true, names.include?("Gray"))
    assert_equal(false, names.include?("Green"))

  end

  test "should knapsack without replacement again" do
    result = FoodHelper.knapsack_without_replacement(Food.where(source: "museum"), 10)

    names = result.map(&:name)

    assert_equal(2, names.length)
    assert_equal(true, names.include?("One"))
    assert_equal(true, names.include?("Three"))
    assert_equal(false, names.include?("Two"))
    assert_equal(false, names.include?("Four"))

  end
end
