# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  $("#foodForm").on("ajax:success", (e, data, status, xhr) ->
    console.log(data)
    calories = data.total_calories
    foodQuantities = JSON.stringify(data.food_quantities)

    source = $("#food-template").html()
    template = Handlebars.compile(source)
    context = { calories: calories, foodQuantities: foodQuantities }
    html = template(context)
    $("#foodResult").html(html))
