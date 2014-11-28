class FoodController < ApplicationController
  def calculate_food
    money = (params[:money].to_f * 100).to_i
    source = params[:source]

    possible_food = Food.where(source: source).where.not(price: nil).where.not(calories: nil)

    result = determine_ratios(possible_food, money)

    respond_to do |format|
      format.json { render json: result, status: :ok }
    end
  end

  def determine_ratios(food, money)
    cache = Array.new(money + 1, 0)
    prev = Array.new(cache.length)

    (1..money).each do |m|
      new_weight = 0
      food.each do |f|
        if f.price > m
          next
        end
        proposed = cache[m - f.price] + f.calories
        if proposed > new_weight
          cache[m] = proposed
          new_weight = proposed
          prev[m] = f
        end
      end
    end

    food_quantities = Hash.new(0)

    money_left = money

    while money_left > 0
      new_food = prev[money_left]

      food_quantities[new_food.name] += 1
      money_left -= new_food.price
    end

    return {
      total_calories: cache[money],
      food_quantities: food_quantities
    }
  end
end
