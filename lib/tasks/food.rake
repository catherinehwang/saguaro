require 'nokogiri'
require 'open-uri'

namespace :taco_bell do
    desc "Add the nutritional information"
    task :nutrition => :environment do
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
    end

    desc "Add price information"
    task :prices => :environment do
      price_page = "http://www.fastfoodmenuprices.com/taco-bell-prices/"

      doc = Nokogiri::HTML(open(price_page))

      rows = doc.css("#tablepress-3").css("tbody").css("tr")

      food_rows = rows.select do |item|
        item.children.count == 3
      end

      non_matches = File.new("log/no_prices.log", "w")

      food_rows.each do |item|
        name = item.css(".column-1").text.gsub(".","")
        special_size = item.css(".column-2").text

        food = Food.find_by(:name => name)

        if !food
          # Price is "Cheesy Burrito (Bacon) but name is Cheesy Burrito - Bacon"
          regex = /\(([^)]*)\)/
          if match = regex.match(name)
            stripped_name = name.gsub(regex, "").strip
            new_name = "#{stripped_name} - #{match[1]}"
            food = Food.find_by(:name => new_name)

            # Price is "Cheesy Burrito (Bacon) but name is Bacon Cheesy Burrito"
            if !food
              new_name = "#{match[1]} #{stripped_name}"
              food = Food.find_by(:name => new_name)
            end
          end
        end

        if !food
          lacking = "#{name} | #{special_size}"
          puts "Couldn't find food: #{lacking}"
          non_matches.write("#{lacking}\n")
          next
        end

        price_string = item.css(".column-3").text

        next if price_string.blank?

        food.price = price_string.gsub(/\D/,'').to_i
        food.save
      end
    end
end

task :taco_bell => ["taco_bell:nutrition", "taco_bell:prices"]

