class Api::V1::Merchants::RevenueByDateController < ApplicationController

  def show
    merchant = Merchant.find(params[:merchant_id])
    render json: MerchantRevenueByDateSerializer.new(merchant.revenue_by_date(params[:date]))
  end
end
