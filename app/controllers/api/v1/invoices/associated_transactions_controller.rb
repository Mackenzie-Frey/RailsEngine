class Api::V1::Invoices::AssociatedTransactionsController < ApplicationController
  def index
    render json: TransactionSerializer.new(Invoice.associated_transactions(look_up_params[:invoice_id]))
  end

  private
  def look_up_params
    params.permit(:invoice_id)
  end
end
