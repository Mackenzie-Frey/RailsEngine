require 'rails_helper'

describe 'Customer API' do
  context 'Record Endpoint' do
    it 'sends a list of merchants' do
      create_list(:customer, 3)

      get '/api/v1/customers.json'

      expect(response).to be_successful

      customers = JSON.parse(response.body)

      expect(customers["data"].count).to eq(3)
      expect(customers["data"].first).to have_key("id")
      expect(customers["data"].first["type"]).to eq("customer")
      expect(customers["data"].first["attributes"]["first_name"]).to eq(Customer.first.first_name)
    end

    it 'sends a single customer' do
      c1 = create(:customer)
      create_list(:customer, 2)

      get "/api/v1/customers/#{c1.id}.json"

      expect(response).to be_successful

      customers = JSON.parse(response.body)

      expect(customers["data"]["id"]).to eq(c1.id.to_s)
      expect(customers["data"]["attributes"]["first_name"]).to eq(c1.first_name)
    end
  end

  context 'Single Finder' do
    xit 'by ID' do
      create(:merchant)
      merchant_1 = create(:merchant)

      get "/api/v1/merchants/find?id=#{merchant_1.id}"

      result = JSON.parse(response.body)

      expect(result["data"]["id"]).to eq(merchant_1.id.to_s)
    end

    xit 'by name' do
      create(:merchant)
      merchant_1 = create(:merchant)

      get "/api/v1/merchants/find?name=#{merchant_1.name}"

      result = JSON.parse(response.body)

      expect(result["data"]["attributes"]["name"]).to eq(merchant_1.name)
    end

    xit 'by created_at' do
      create(:merchant)
      merchant_1 = create(:merchant, created_at: "2012-03-27 14:53:59 UTC")

      get "/api/v1/merchants/find?created_at=#{merchant_1.created_at}"

      result = JSON.parse(response.body)

      expect(result["data"]["id"]).to eq(merchant_1.id.to_s)
    end

    xit 'by updated_at' do
      create(:merchant)
      merchant_1 = create(:merchant, updated_at: "2012-03-27 14:53:59 UTC")

      get "/api/v1/merchants/find?updated_at=#{merchant_1.updated_at}"

      result = JSON.parse(response.body)

      expect(result["data"]["id"]).to eq(merchant_1.id.to_s)
    end
  end

  context 'Multi-Finders' do
    xit 'by id' do
      create(:merchant)
      merchant = create(:merchant)

      get "/api/v1/merchants/find_all?id=#{merchant.id}"

      result = JSON.parse(response.body)

      expect(result["data"][0]["id"]).to eq(merchant.id.to_s)
    end

    xit 'by name' do
      create(:merchant)
      name = "Generic Name"
      merchant_1 = create(:merchant, name: name)
      merchant_2 = create(:merchant, name: name)

      get "/api/v1/merchants/find_all?name=#{name}"

      result = JSON.parse(response.body)

      expect(result["data"].count).to eq(2)
      expect(result["data"][0]["id"]).to eq(merchant_1.id.to_s)
      expect(result["data"][1]["id"]).to eq(merchant_2.id.to_s)
    end

    xit 'by created_at' do
      create(:merchant)
      merchant_1 = create(:merchant, created_at: "2012-03-27 14:53:59 UTC")
      merchant_2 = create(:merchant, created_at: "2012-03-27 14:53:59 UTC")

      get "/api/v1/merchants/find_all?created_at=2012-03-27 14:53:59 UTC"

      result = JSON.parse(response.body)

      expect(result["data"].count).to eq(2)
      expect(result["data"][0]["id"]).to eq(merchant_1.id.to_s)
      expect(result["data"][1]["id"]).to eq(merchant_2.id.to_s)
    end

    xit 'by updated_at' do
      create(:merchant)
      merchant_1 = create(:merchant, updated_at: "2012-03-27 14:53:59 UTC")
      merchant_2 = create(:merchant, updated_at: "2012-03-27 14:53:59 UTC")

      get "/api/v1/merchants/find_all?updated_at=2012-03-27 14:53:59 UTC"

      result = JSON.parse(response.body)

      expect(result["data"].count).to eq(2)
      expect(result["data"][0]["id"]).to eq(merchant_1.id.to_s)
      expect(result["data"][1]["id"]).to eq(merchant_2.id.to_s)
    end
  end

  context 'Random' do
    xit 'resource' do
      merchant_1 = create(:merchant)
      merchant_2 = create(:merchant)

      get '/api/v1/merchants/random.json'

      result = JSON.parse(response.body)
      expect(result["data"]["id"]).to eq(merchant_1.id.to_s).or eq(merchant_2.id.to_s)
    end
  end

  context 'Relationships' do
  end

  context 'Business Intelligence' do
    context 'all merchants' do
    end
    context 'single merchant' do
    end
  end
end
