class Api::V1::Items::AssociatedMerchantController < ApplicationController
  def show
    render json: MerchantSerializer.new(Item.associated_merchant(look_up_params[:item_id]))
  end

  private
  def look_up_params
    params.permit(:item_id)
  end
end
