class Api::V1::InvoiceItemsController < ApplicationController
  def index
    render json: InvoiceItemSerializer.new(InvoiceItem.all)
  end

  def show
    render json: InvoiceItemSerializer.new(InvoiceItem.find(look_up_params[:id]))
  end

  private
  def look_up_params
    params.permit(:id)
  end
end
