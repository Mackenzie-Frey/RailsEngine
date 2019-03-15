class Api::V1::Merchants::RevenueByDateController < ApplicationController
  def show
    merchant = Merchant.find(params[:merchant_id])
    render json: SingleMerchantRevenueByDateSerializer.new(merchant.revenue_by_date(params[:date]))
  end

  def index
    render json: AllMerchantRevenueByDateSerializer.new(InvoiceItem.revenue_by_date(params[:date]))
  end
end
