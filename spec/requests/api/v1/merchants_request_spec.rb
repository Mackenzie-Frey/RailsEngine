require 'rails_helper'

describe "Merchant API" do
  it "sends a list of merchants" do
    create_list(:merchant, 3)

    get '/api/v1/merchants.json'

    expect(response).to be_successful

    merchants = JSON.parse(response.body)

    expect(merchants["data"].count).to eq(3)
    expect(merchants["data"].first).to have_key("id")
    expect(merchants["data"].first["type"]).to eq("merchant")
    expect(merchants["data"].first["attributes"]["name"]).to eq(Merchant.first.name)
  end

  it "sends a single merchant" do
    m1 = create(:merchant)
    create(:merchant)
    create(:merchant)

    get "/api/v1/merchants/#{m1.id}.json"

    expect(response).to be_successful

    merchants = JSON.parse(response.body)

    expect(merchants["data"]["id"]).to eq(m1.id.to_s)
    expect(merchants["data"]["attributes"]["name"]).to eq(m1.name)
  end
end
