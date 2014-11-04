# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20141031071205) do

  create_table "foods", force: true do |t|
    t.string   "name"
    t.integer  "serving_size"
    t.integer  "calories"
    t.integer  "calories_from_fat"
    t.integer  "saturated_fat"
    t.integer  "total_fat"
    t.integer  "trans_fat"
    t.integer  "cholesterol"
    t.integer  "sodium"
    t.integer  "carbohydrates"
    t.integer  "dietary_fiber"
    t.integer  "sugars"
    t.integer  "protein"
    t.string   "source"
    t.integer  "price"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "foods", ["name"], name: "index_foods_on_name", unique: true

end
