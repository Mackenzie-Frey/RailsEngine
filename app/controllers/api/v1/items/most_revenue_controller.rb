class Api::V1::Items::MostRevenueController < ApplicationController
  def index
    render json: ItemSerializer.new(Item.most_revenue(look_up_params[:quantity]))
  end

  private
  def look_up_params
    params.permit(:quantity)
  end
end
