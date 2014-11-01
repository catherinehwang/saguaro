require 'nokogiri'
require 'open-uri'

price_page = "http://www.fastfoodmenuprices.com/taco-bell-prices/"

doc = Nokogiri::HTML(open(price_page))

rows = doc.css("#tablepress-3").css("tbody").css("tr")

food_rows = rows.select do |item|
  item.children.count == 3
end

food_rows.each do |item|
  name = item.css(".column-1").text

  food = Food.find_by(:name => name)

  if !food
    puts "Couldn't find food: #{name}"
    next
  end

  special_size = item.css(".column-2").text
  food.price = item.css(".column-3").text.gsub(/\D/,'').to_i
  food.save
end
