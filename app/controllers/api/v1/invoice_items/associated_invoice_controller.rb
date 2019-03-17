class Api::V1::InvoiceItems::AssociatedInvoiceController < ApplicationController
  def show
    render json: InvoiceSerializer.new(InvoiceItem.find_invoice(look_up_params['invoice_item_id']))
  end

  private
  def look_up_params
    params.permit(:invoice_item_id)
  end
end
