class Api::V1::FoodController < ApplicationController
  # GET /food
  def index
    @food = Food.all
  end

  # GET /food/1
  def show
    @food = Food.find(params[:id])
  end

  # GET /meal
  # Determines the optimal meal given some money as a constraint.
  #
  # @param [Integer] money Amount of money in cents
  #
  # @param [String] source Name of the restaurant
  #
  # @return [Array] an array of food
  def meal
    money = params[:money].to_f
    source = params[:source]

    possible_food = Food.where(source: source).where.not(price: nil).where.not(calories: nil)

    @food = FoodHelper.knapsack_without_replacement(possible_food, money)
  end

end
