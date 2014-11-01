class FoodController < ApplicationController
  def index
    @money = params[:money]

    respond_to do |format|
        format.json { render json: @money, status: :ok }
    end
  end
end
