class Api::V1::Items::SearchController < ApplicationController
  def show
    render json: ItemSerializer.new(Item.find_by(look_up_params))
  end

  def index
    render json: ItemSerializer.new(Item.where(look_up_params))
  end

  private
  def look_up_params
    params.permit(:id, :name, :description, :unit_price, :created_at, :updated_at, :merchant_id)
  end
end
