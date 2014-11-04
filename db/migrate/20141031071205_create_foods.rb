class CreateFoods < ActiveRecord::Migration
  def change
    create_table :foods do |t|
      t.string :name
      t.integer :serving_size
      t.integer :calories
      t.integer :calories_from_fat
      t.integer :saturated_fat
      t.integer :total_fat
      t.integer :trans_fat
      t.integer :cholesterol
      t.integer :sodium
      t.integer :carbohydrates
      t.integer :dietary_fiber
      t.integer :sugars
      t.integer :protein
      t.string :source
      t.integer :price

      t.timestamps
    end

    add_index :foods, :name, :unique => true
  end
end
