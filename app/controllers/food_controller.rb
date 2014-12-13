class FoodController < ApplicationController
  # GET /meal
  # Determines the optimal meal given some money as a constraint.
  #
  # @param [String] money Amount of money in dollars. 
  #
  # @param [String] source Name of the restaurant
  #
  # @return [Array] an array of food

  def meal
    money = (params[:money].to_f * 100).to_i
    source = params[:source]

    possible_food = Food.where(source: source).where.not(price: nil).where.not(calories: nil)

    @food = FoodHelper.knapsack_without_replacement(possible_food, money)
    @calories = @food.map(&:calories).reduce(:+)
  end
end
