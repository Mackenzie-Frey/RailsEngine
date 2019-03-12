require 'rails_helper'

describe "Merchant API" do
  it "sends a list of merchants" do
    create_list(:merchant, 3)

    get '/api/v1/merchants.json'

    expect(response).to be_successful

    merchants = response.body

    expect(merchants.count).to eq(3)
    expect(merchants.first).to have_key("id")
  end

end
