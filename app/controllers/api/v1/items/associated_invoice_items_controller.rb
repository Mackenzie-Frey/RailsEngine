class Api::V1::Items::AssociatedInvoiceItemsController < ApplicationController
  def index
    render json: InvoiceItemSerializer.new(Item.associated_invoice_items(look_up_params[:item_id]))
  end

  private
  def look_up_params
    params.permit(:item_id)
  end
end
