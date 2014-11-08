namespace :taco_bell do
    desc "Add the nutritional information"
    task :nutrition => :environment do
      puts "Add nutritional information"
    end

    desc "Add price information"
    task :prices do
      puts "Add price information"
    end
end

task :taco_bell => ["taco_bell:nutrition", "taco_bell:prices"]

