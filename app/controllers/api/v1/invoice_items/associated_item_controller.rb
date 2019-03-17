class Api::V1::InvoiceItems::AssociatedItemController < ApplicationController
  def show
    render json: ItemSerializer.new(InvoiceItem.find_item(look_up_params[:invoice_item_id]))
  end

  private
  def look_up_params
    params.permit(:invoice_item_id)
  end
end
