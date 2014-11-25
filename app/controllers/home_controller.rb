class HomeController < ApplicationController
  def index
    @sources = Food.uniq.pluck(:source)
  end
end
