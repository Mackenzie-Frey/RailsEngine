class Api::V1::InvoiceItems::SearchController < ApplicationController
  def show
    render json: InvoiceItemSerializer.new(InvoiceItem.find_by(look_up_params))
  end

  def index
    render json: InvoiceItemSerializer.new(InvoiceItem.where(look_up_params))
  end

  private
  def look_up_params
    params.permit(:id)
  end
end
