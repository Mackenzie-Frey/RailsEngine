class Api::V1::Merchants::FavoriteCustomerController < ApplicationController
  def show
    render json: CustomerSerializer.new(Merchant.favorite_customer(params[:merchant_id]))
  end
end
