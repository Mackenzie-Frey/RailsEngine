class Api::V1::InvoicesController < ApplicationController
  def index
    render json: InvoiceSerializer.new(Invoice.all)
  end

  def show
    render json: InvoiceSerializer.new(Invoice.find_by(look_up_params))
  end

  private
  def look_up_params
    params.permit(:id)
  end

end
