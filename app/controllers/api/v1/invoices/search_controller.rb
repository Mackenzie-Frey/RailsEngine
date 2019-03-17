class Api::V1::Invoices::SearchController < ApplicationController
  def show
    render json: InvoiceSerializer.new(Invoice.find_by(look_up_params))
  end

  def index
    render json: InvoiceSerializer.new(Invoice.where(look_up_params))
  end

  private
  def look_up_params
    params.permit(:id, :customer_id, :merchant_id, :status, :created_at, :updated_at)
  end
end
