# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  $("#foodForm").on("ajax:success", (e, data, status, xhr) ->
    calories = data.total_calories

    caloriesTemplate = $("#calories-template").html()
    caloriesCompiledTemplate = Handlebars.compile(caloriesTemplate)
    caloriesContext = { calories: calories }
    caloriesHtml = caloriesCompiledTemplate(caloriesContext)
    $("#foodResult").append(caloriesHtml)

    foodQuantities = data.food_quantities
    foodTemplate = $("#food-template").html()
    foodCompiledTemplate = Handlebars.compile(foodTemplate)

    $.each(foodQuantities, (name, food) ->
      foodContext = { name: name, calories: food.calories, price: food.price, quantity: food.quantity }
      foodHtml = foodCompiledTemplate(foodContext)
      $("#foodContent").append(foodHtml)
    )
  )
