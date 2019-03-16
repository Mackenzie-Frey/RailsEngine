class Api::V1::Customers::TransactionsOfCustomerController < ApplicationController
  def index
    render json: TransactionSerializer.new(Customer.find_transactions(params[:customer_id]))
  end
end
