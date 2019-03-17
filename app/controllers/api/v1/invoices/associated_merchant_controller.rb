class Api::V1::Invoices::AssociatedMerchantController < ApplicationController
  def show
    render json: MerchantSerializer.new(Invoice.find_by(id: look_up_params[:invoice_id]).merchant)
  end

  private
  def look_up_params
    params.permit(:invoice_id)
  end
end
