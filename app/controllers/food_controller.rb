class FoodController < ApplicationController
  def calculate_food
    money = (params[:money].to_f * 100).to_i
    source = params[:source]

    possible_food = Food.where(source: source).where.not(price: nil).where.not(calories: nil)

    result = FoodHelper.determine_knapsack(possible_food, money)

    respond_to do |format|
      format.json { render json: result, status: :ok }
    end
  end
end
