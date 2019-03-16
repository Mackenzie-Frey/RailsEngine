class Api::V1::ItemsController < ApplicationController
  def index
    render json: ItemSerializer.new(Item.all)
  end

  def show
    render json: ItemSerializer.new(Item.find(look_up_params['id']))
  end

  private
  def look_up_params
    params.permit(:id)
  end
end
