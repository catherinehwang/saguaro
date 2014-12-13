class FoodController < ApplicationController
  def meal
    money = (params[:money].to_f * 100).to_i
    source = params[:source]

    possible_food = Food.where(source: source).where.not(price: nil).where.not(calories: nil)

    result = FoodHelper.knapsack_without_replacement(possible_food, money)

    respond_to do |format|
      format.json { render json: result, status: :ok }
    end
  end
end
