class Api::V1::Invoices::AssociatedInvoiceItemsController < ApplicationController
  def index
    render json: InvoiceItemSerializer.new(Invoice.associated_invoice_items(look_up_params[:invoice_id]))
  end

  private
  def look_up_params
    params.permit(:invoice_id)
  end
end
