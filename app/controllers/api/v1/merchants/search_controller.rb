class Api::V1::Merchants::SearchController < ApplicationController
  def show
    render json: MerchantSerializer.new(Merchant.find_by(look_up_params))
  end

  def index
    render json: MerchantSerializer.new(Merchant.where(look_up_params))
  end

  private
  def look_up_params
    params.permit(:id, :name, :created_at, :updated_at)
  end
end
