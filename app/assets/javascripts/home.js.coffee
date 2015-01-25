# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  $("#foodForm").on("ajax:success", (e, data, status, xhr) ->
    calories = data.calories
    totalPrice = data.total_price

    caloriesTemplate = $("#calories-template").html()
    caloriesCompiledTemplate = Handlebars.compile(caloriesTemplate)
    caloriesContext = { calories: calories, price: totalPrice }
    caloriesHtml = caloriesCompiledTemplate(caloriesContext)
    $("#foodResult").html(caloriesHtml)

    foodList = data.food
    foodTemplate = $("#food-template").html()
    foodCompiledTemplate = Handlebars.compile(foodTemplate)

    $.each(foodList, (index, food) ->
      price = "$#{(food.price / 100).toFixed(2)}"
      foodContext = { name: food.name, calories: food.calories, price: price }
      foodHtml = foodCompiledTemplate(foodContext)
      $("#foodContent").append(foodHtml)
    )

    $("html, body").animate(
      { scrollTop: $("#foodResult").offset().top }, 500
    )
  )
