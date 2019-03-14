class Api::V1::Merchants::ItemsByMerchantController < ApplicationController
  def index
    render json: ItemSerializer.new(Merchant.find(look_up_params[:merchant_id]).items)
    # render json: ItemSerializer.new(Merchant.find(params[:merchant_id]).items)
  end

  private
  def look_up_params
    params.permit(:merchant_id)
  end
end
