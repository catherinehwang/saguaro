require 'nokogiri'
require 'open-uri'

nutritional_page = "http://www.tacobell.com/nutrition/information"

# Get a Nokogiri::HTML::Document for the page

doc = Nokogiri::HTML(open(nutritional_page))

# Now parse it with Nokogiri::XML::Node methods

rows = doc.css("#nutrInfo").css("tbody").css("tr")

food_rows = rows.select do |item|
  item.attribute("class") == nil
end

food_rows.each do |item|

  name = item.css("th").text.gsub(/[^0-9a-z -]/i, "").strip

  food = Food.find_or_create_by(:name => name)
  info = item.css("td")

  food.serving_size = info[0].text
  food.calories = info[1].text
  food.calories_from_fat = info[2].text
  food.saturated_fat = info[3].text
  food.total_fat = info[4].text
  food.trans_fat = info[5].text
  food.cholesterol = info[6].text
  food.sodium = info[7].text
  food.carbohydrates = info[8].text
  food.dietary_fiber = info[9].text
  food.sugars = info[10].text
  food.protein = info[11].text
  food.source = "Taco Bell"

  food.save

end
