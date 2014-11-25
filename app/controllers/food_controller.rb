class FoodController < ApplicationController
  def index
    money = params[:money]

    food_list = calculate_food(money)
    respond_to do |format|
        format.json { render json: food_list, status: :ok }
    end
  end

  def calculate_food
    money = params[:money]
    source = params[:source]

    possible_food = Food.where(source: source)

    result = possible_food.map do |food|
      food.name
    end

    respond_to do |format|
      format.json { render json: result, status: :ok }
    end
  end
end
