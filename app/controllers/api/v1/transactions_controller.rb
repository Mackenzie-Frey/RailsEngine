class Api::V1::TransactionsController < ApplicationController
  def index
    render json: TransactionSerializer.new(Transaction.all)
  end

  def show
    render json: TransactionSerializer.new(Transaction.find(look_up_params[:id]))
  end

  private
  def look_up_params
    params.permit(:id)
  end

end
