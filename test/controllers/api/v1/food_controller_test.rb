require "test_helper"

describe Api::V1::FoodController do
  it "should return a list of food" do
    get "index", :format => "json"

    response.success?.must_equal true

    items = JSON.parse(response.body)

    items.length.must_equal 9

  end
end
