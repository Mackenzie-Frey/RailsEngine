class Api::V1::MerchantsController < ApplicationController
  def index
    render json: Merchant.all
    #why is the below line done in the test and not the code?
    JSON.parse(response.body)
  end
end
