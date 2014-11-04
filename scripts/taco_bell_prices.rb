require 'nokogiri'
require 'open-uri'

price_page = "http://www.fastfoodmenuprices.com/taco-bell-prices/"

doc = Nokogiri::HTML(open(price_page))

rows = doc.css("#tablepress-3").css("tbody").css("tr")

food_rows = rows.select do |item|
  item.children.count == 3
end

non_matches = File.new("log/no_prices.log", "w")

food_rows.each do |item|
  name = item.css(".column-1").text
  special_size = item.css(".column-2").text

  food = Food.find_by(:name => name)

  if !food
    # Price is "Cheesy Burrito (Bacon) but name is Cheesy Burrito - Bacon"
    regex = /\(([^)]*)\)/
    if match = regex.match(name)
      stripped_name = name.gsub(regex, "").strip
      new_name = "#{stripped_name} - #{match[1]}"
      food = Food.find_by(:name => new_name)
    end
  end

  if !food
    puts "Couldn't find food: #{name}"
    non_matches.write("#{name}\n")
    next
  end

  food.price = item.css(".column-3").text.gsub(/\D/,'').to_i
  food.save
end
