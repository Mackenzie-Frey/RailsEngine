class Api::V1::Invoices::AssociatedItemsController < ApplicationController
  def index
    render json: ItemSerializer.new(Invoice.associated_items(look_up_params[:invoice_id]))
  end

  private
  def look_up_params
    params.permit(:invoice_id)
  end
end
