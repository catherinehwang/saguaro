require 'nokogiri'
require 'open-uri'

nutritional_page = "http://www.tacobell.com/nutrition/information"

# Get a Nokogiri::HTML::Document for the page

doc = Nokogiri::HTML(open(nutritional_page))

# Now parse it with Nokogiri::XML::Node methods

rows = doc.css("#nutrInfo").css("tbody").css("tr")

food = rows.select do |item|
  item.attribute("class") == nil
end

food.each do |item|
  name = item.css("th").text
  info = item.css("td")

  serving_size = info[0].text
  calories = info[1].text
  calories_from_fat = info[2].text
  saturated_fat = info[3].text
  total_fat = info[4].text
  trans_fat = info[5].text
  cholesterol = info[6].text
  sodium = info[7].text
  carbohydrates = info[8].text
  dietary_fiber = info[9].text
  sugars = info[10].text
  protein = info[11].text
end
