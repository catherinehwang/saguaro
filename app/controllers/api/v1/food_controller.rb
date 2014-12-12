class Api::V1::FoodController < ApplicationController
  # GET /food
  def index
    @food = Food.all
    render 'index'
  end

  # GET /food/1
  def show
    @food = Food.find(params[:id])
    render '_show'
  end

  # GET /meal
  # 
  # @param [Integer] money Amount of money in cents
  #
  # @param [String] source Name of the restaurant
  #
  # @return [Hash]
  def meal
    money = params[:money].to_f
    source = params[:source]

    possible_food = Food.where(source: source).where.not(price: nil).where.not(calories: nil)

    result = FoodHelper.knapsack_without_replacement(possible_food, money)

    render json: result

  end

end
