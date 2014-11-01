class FoodController < ApplicationController
  def index
    money = params[:money]

    food_list = calculate_food(money)
    respond_to do |format|
        format.json { render json: food_list, status: :ok }
    end
  end

  def calculate_food(money)
    # Assume Taco Bell for now
    possible_food = Food.where(source: "Taco Bell")

    return possible_food.map do |food| 
      food.name
    end
  end
end
