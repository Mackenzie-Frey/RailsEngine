class Api::V1::Merchants::RandomController < ApplicationController
  def show
    render json: MerchantSerializer.new(Merchant.all.shuffle.pop)
  end
end
