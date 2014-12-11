class Api::V1::FoodController < ApplicationController
  # GET /foods
  def index
    foods = Food.all
    render json: foods
  end

  # GET /foods/1
  def show
    food = Food.find(params[:id])
    render json: food
  end

  # GET /meal
  def meal
    money = params[:money].to_f
    source = params[:source]

    possible_food = Food.where(source: source).where.not(price: nil).where.not(calories: nil)

    result = FoodHelper.knapsack_without_replacement(possible_food, money)

    render json: result

  end

end
