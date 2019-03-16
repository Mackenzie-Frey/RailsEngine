class Api::V1::Customers::SearchController < ApplicationController
  def show
    render json: CustomerSerializer.new(Customer.find_by(look_up_params))
  end

  private
  def look_up_params
    params.permit(:id, :first_name, :last_name, :created_at, :updated_at)
  end
end
