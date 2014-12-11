class API::V1::FoodController < ApplicationController
  before_action :set_food, only: [ :show, :edit, :update, :destroy ]

  # GET /foods
  def index
    @foods = Food.all
  end

  # GET /foods/1
  def show
    @food = Food.find(params[:id])
  end

  # Whitelist params
  def food_params
    params[:food]
  end
end
