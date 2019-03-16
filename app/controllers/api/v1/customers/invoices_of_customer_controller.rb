class Api::V1::Customers::InvoicesOfCustomerController < ApplicationController
  def index
    render json: InvoiceSerializer.new((Customer.find_by(look_up_params)).invoices)
  end

  private
  def look_up_params
    params.permit(:id)
  end
end
