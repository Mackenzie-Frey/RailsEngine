class Api::V1::Merchants::SearchController < ApplicationController
  def show
    render json: MerchantSerializer.new(Merchant.find(params[merchant_params]))
  end

  private
  def merchant_params
    params.require(:merchant).permit(:id, :name, :created_at, :updated_at)
  end
end
