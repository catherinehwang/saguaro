# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  $("#foodForm").on("ajax:success", (e, data, status, xhr) ->
    calories = data.calories

    caloriesTemplate = $("#calories-template").html()
    caloriesCompiledTemplate = Handlebars.compile(caloriesTemplate)
    caloriesContext = { calories: calories }
    caloriesHtml = caloriesCompiledTemplate(caloriesContext)
    $("#foodResult").html(caloriesHtml)

    foodList = data.food
    foodTemplate = $("#food-template").html()
    foodCompiledTemplate = Handlebars.compile(foodTemplate)

    $.each(foodList, (index, food) ->
      foodContext = { name: food.name, calories: food.calories, price: food.price }
      foodHtml = foodCompiledTemplate(foodContext)
      $("#foodContent").append(foodHtml)
    )

    $("html, body").animate(
      { scrollTop: $("#foodResult").offset().top }, 500
    )
  )
