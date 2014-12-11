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

  # Whitelist params
  def food_params
    params[:food]
  end
end
