class Api::V1::Transactions::AssociatedInvoiceController < ApplicationController
  def show
    render json: InvoiceSerializer.new(Transaction.find_by(id: look_up_params[:transaction_id]).invoice)
  end

  private
  def look_up_params
    params.permit(:transaction_id)
  end
end
