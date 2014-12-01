module FoodHelper
  def determine_knapsack(food, money)
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
  module_function :determine_knapsack
end
