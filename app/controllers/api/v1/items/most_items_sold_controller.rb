class Api::V1::Items::MostItemsSoldController < ApplicationController
  def index
    render json: ItemSerializer.new(Item.most_items_sold(look_up_params[:quantity]))
  end

  private
  def look_up_params
    params.permit(:quantity)
  end
end
