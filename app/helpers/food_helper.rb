module FoodHelper
  def knapsack_with_replacement(food, money)
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
  module_function :knapsack_with_replacement

  def knapsack_without_replacement(food, money)
    # cache[m][f] : max calories of including foods 1..f with max money m
    cache = Array.new(money + 1)
    cache.each_with_index do |_, i|
      cache[i] = Array.new(food.length + 1, 0)
    end

    # includes_matrix[m][f] : does the optimal solution with foods 1..f with max money m include item f?
    includes_matrix = Array.new(money + 1)
    includes_matrix.each_with_index do |_, i|
      includes_matrix[i] = Array.new(food.length + 1)
    end

    (1..food.length).each do |f|
      current_food = food[f-1]
      (1..money).each do |m|
        if current_food.price > m
          cache[m][f] = cache[m][f-1]
          includes_matrix[m][f] = false
        else
          not_include = cache[m][f-1]
          include = cache[m-current_food.price][f-1] + current_food.calories

          if include > not_include
            cache[m][f] = include
            includes_matrix[m][f] = true
          else
            cache[m][f] = not_include
            includes_matrix[m][f] = false
          end
        end
      end
    end


    # Now we must determine which items were involved in the optimal solution

    items_taken_status = Array.new(food.length, false)

    money_left = money

    food.length.downto(1).each do |f|
      if includes_matrix[money_left][f]
        items_taken_status[f] = true
        money_left -= food[f-1].price
      end
    end

    food_quantities = {}


    items_taken_status.each_with_index do |status, index|
      if status
        current_food = food[index-1]
        food_quantities[current_food.name] = {
          calories: current_food.calories,
          price: "$%.2f" % (current_food.price.to_f / 100),
          quantity: 1
        }
      end
    end

    return {
      total_calories: cache[money][food.length],
      food_quantities: food_quantities
    }

  end
  module_function :knapsack_without_replacement
end
