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

    food_quantities = {}

    money_left = money

    while money_left > 0
      new_food = prev[money_left]

      entry = food_quantities[new_food.name]

      if entry
        entry[:price] += new_food.price
        entry[:quantity] += 1
      else
        food_quantities[new_food.name] = {
          price: new_food.price,
          quantity: 1
        }
      end

      money_left -= new_food.price
    end

    return {
      total_calories: cache[money],
      food_quantities: food_quantities
    }
  end
  module_function :determine_knapsack
end
