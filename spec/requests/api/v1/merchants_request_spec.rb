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
    create_list(:merchant, 2)

    get "/api/v1/merchants/#{m1.id}.json"

    expect(response).to be_successful

    merchants = JSON.parse(response.body)

    expect(merchants["data"]["id"]).to eq(m1.id.to_s)
    expect(merchants["data"]["attributes"]["name"]).to eq(m1.name)
  end

  it 'returns the top x merchants ranked by total revenue' do
    customer_1 = create(:customer)

    merchant_1 = create(:merchant)
    merchant_2 = create(:merchant)
    merchant_3 = create(:merchant)

    item_1 = create(:item, merchant: merchant_1)
    item_2 = create(:item, merchant: merchant_2)
    item_3 = create(:item, merchant: merchant_3)

    invoice_1 = create(:invoice, customer: customer_1, merchant: merchant_1)
    invoice_2 = create(:invoice, customer: customer_1, merchant: merchant_2)
    invoice_3 = create(:invoice, customer: customer_1, merchant: merchant_3)

    create(:invoice_item, item: item_1, invoice: invoice_1, quantity: 10, unit_price: 500)
    create(:invoice_item, item: item_2, invoice: invoice_2, quantity: 20, unit_price: 500)
    create(:invoice_item, item: item_3, invoice: invoice_3, quantity: 30, unit_price: 500)

    create(:transaction, invoice: invoice_1, result: "success")
    create(:transaction, invoice: invoice_2, result: "success")
    create(:transaction, invoice: invoice_3, result: "failed")

    get '/api/v1/merchants/most_revenue?quantity=2'

    result = JSON.parse(response.body)

    expect(result["data"]).to eq([])
  end
end
