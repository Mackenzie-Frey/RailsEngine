class Api::V1::Invoices::AssociatedCustomerController < ApplicationController
  def show
    render json: CustomerSerializer.new(Invoice.find_by(id: look_up_params[:invoice_id]).customer)
  end

  private
  def look_up_params
    params.permit(:invoice_id)
  end
end
