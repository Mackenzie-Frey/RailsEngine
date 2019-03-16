require 'rails_helper'

describe 'Item API' do
  context 'Record Endpoint' do
    it 'sends a list of items' do
      create_list(:item, 3)

      get '/api/v1/items.json'

      expect(response).to be_successful

      items = JSON.parse(response.body)

      expect(items["data"].count).to eq(3)
      expect(items["data"].first).to have_key("id")
      expect(items["data"].first["type"]).to eq("item")
    end

    it 'sends a single item' do
      i1 = create(:item)
      create_list(:item, 2)

      get "/api/v1/items/#{i1.id}.json"

      expect(response).to be_successful

      items = JSON.parse(response.body)

      expect(items["data"]["id"]).to eq(i1.id.to_s)
    end
  end

  context 'Single Finder' do
    xit 'by ID' do
      create(:customer)
      customer_1 = create(:customer)

      get "/api/v1/customers/find?id=#{customer_1.id}"

      result = JSON.parse(response.body)

      expect(result["data"]["id"]).to eq(customer_1.id.to_s)
    end

    xit 'by first name' do
      customer_1 = create(:customer)

      get "/api/v1/customers/find?name=#{customer_1.first_name}"

      result = JSON.parse(response.body)

      expect(result["data"]["attributes"]["first_name"]).to eq(customer_1.first_name)
    end

    xit 'by last name' do
      customer_1 = create(:customer)

      get "/api/v1/customers/find?name=#{customer_1.last_name}"

      result = JSON.parse(response.body)

      expect(result["data"]["attributes"]["last_name"]).to eq(customer_1.last_name)
    end

    xit 'by created_at' do
      create(:customer)
      customer_1 = create(:customer, created_at: "2012-03-27 14:53:59 UTC")

      get "/api/v1/customers/find?created_at=#{customer_1.created_at}"

      result = JSON.parse(response.body)

      expect(result["data"]["id"]).to eq(customer_1.id.to_s)
    end

    xit 'by updated_at' do
      create(:customer)
      customer_1 = create(:customer, updated_at: "2012-03-27 14:53:59 UTC")

      get "/api/v1/customers/find?updated_at=#{customer_1.updated_at}"

      result = JSON.parse(response.body)

      expect(result["data"]["id"]).to eq(customer_1.id.to_s)
    end
  end

  context 'Multi-Finders' do
    xit 'by id' do
      create(:customer)
      customer = create(:customer)

      get "/api/v1/customers/find_all?id=#{customer.id}"

      result = JSON.parse(response.body)

      expect(result["data"][0]["id"]).to eq(customer.id.to_s)
    end

    xit 'by first_name' do
      create(:customer)
      first_name = "Generic Name"
      customer_1 = create(:customer, first_name: first_name)
      customer_2 = create(:customer, first_name: first_name)

      get "/api/v1/customers/find_all?first_name=#{first_name}"

      result = JSON.parse(response.body)

      expect(result["data"].count).to eq(2)
      expect(result["data"][0]["id"]).to eq(customer_1.id.to_s)
      expect(result["data"][1]["id"]).to eq(customer_2.id.to_s)
    end

    xit 'by last_name' do
      create(:customer)
      last_name = "Generic Name"
      customer_1 = create(:customer, last_name: last_name)
      customer_2 = create(:customer, last_name: last_name)

      get "/api/v1/customers/find_all?last_name=#{last_name}"

      result = JSON.parse(response.body)

      expect(result["data"].count).to eq(2)
      expect(result["data"][0]["id"]).to eq(customer_1.id.to_s)
      expect(result["data"][1]["id"]).to eq(customer_2.id.to_s)
    end

    xit 'by created_at' do
      create(:customer)
      customer_1 = create(:customer, created_at: "2012-03-27 14:53:59 UTC")
      customer_2 = create(:customer, created_at: "2012-03-27 14:53:59 UTC")

      get "/api/v1/customers/find_all?created_at=2012-03-27 14:53:59 UTC"

      result = JSON.parse(response.body)

      expect(result["data"].count).to eq(2)
      expect(result["data"][0]["id"]).to eq(customer_1.id.to_s)
      expect(result["data"][1]["id"]).to eq(customer_2.id.to_s)
    end

    xit 'by updated_at' do
      create(:customer)
      customer_1 = create(:customer, updated_at: "2012-03-27 14:53:59 UTC")
      customer_2 = create(:customer, updated_at: "2012-03-27 14:53:59 UTC")

      get "/api/v1/customers/find_all?updated_at=2012-03-27 14:53:59 UTC"

      result = JSON.parse(response.body)

      expect(result["data"].count).to eq(2)
      expect(result["data"][0]["id"]).to eq(customer_1.id.to_s)
      expect(result["data"][1]["id"]).to eq(customer_2.id.to_s)
    end
  end

  context 'Random' do
    xit 'resource' do
      customer_1 = create(:customer)
      customer_2 = create(:customer)

      get '/api/v1/customers/random.json'

      result = JSON.parse(response.body)
      expect(result["data"]["id"]).to eq(customer_1.id.to_s).or eq(customer_2.id.to_s)
    end
  end

  context 'Relationships' do
    xit 'returns a collection of associated invoices' do
      customer_1 = create(:customer)
      customer_2 = create(:customer)
      create(:invoice, customer: customer_1)
      create(:invoice, customer: customer_1)
      create(:invoice, customer: customer_2)

      get "/api/v1/customers/#{customer_1.id}/invoices"

      result = JSON.parse(response.body)

      expect(result['data'].count).to eq(2)
      expect(result['data'][0]['attributes']['customer_id']).to eq(customer_1.id)
      expect(result['data'][1]['attributes']['customer_id']).to eq(customer_1.id)
    end

    xit 'returns a collection of associated transactions' do
      customer_1 = create(:customer)
      customer_2 = create(:customer)

      invoice_1 = create(:invoice, customer: customer_1)
      invoice_2 = create(:invoice, customer: customer_1)
      invoice_3 = create(:invoice, customer: customer_2)

      transaction_1 = create(:transaction, invoice: invoice_1, result: 'success')
      transaction_2 = create(:transaction, invoice: invoice_2, result: 'failed')
      create(:transaction, invoice: invoice_3, result: 'success')

      get "/api/v1/customers/#{customer_1.id}/transactions"

      result = JSON.parse(response.body)

      expect(result['data'].count).to eq(2)

      expect(result['data'][0]['attributes']['id']).to eq(transaction_1.id)
      expect(result['data'][1]['attributes']['id']).to eq(transaction_2.id)
      expect(result['data'][1]['type']).to eq('transaction')
    end
  end

  context 'Business Intelligence' do
    xit 'returns a merchant where the customer has conducted the most successful transactions' do
      merchant_1 = create(:merchant)
      merchant_2 = create(:merchant)

      customer_1 = create(:customer)
      customer_2 = create(:customer)

      invoice_1 = create(:invoice, customer: customer_1, merchant: merchant_1)
      invoice_2 = create(:invoice, customer: customer_1, merchant: merchant_1)
      invoice_3 = create(:invoice, customer: customer_2, merchant: merchant_2)
      invoice_4 = create(:invoice, customer: customer_1, merchant: merchant_2)

      create(:transaction, invoice: invoice_1, result: 'success')
      create(:transaction, invoice: invoice_2, result: 'failed')
      create(:transaction, invoice: invoice_2, result: 'success')
      create(:transaction, invoice: invoice_3, result: 'success')
      create(:transaction, invoice: invoice_4, result: 'success')

      get "/api/v1/customers/#{customer_1.id}/favorite_merchant"
      result = JSON.parse(response.body)

      expect(result['data']['id']).to eq(merchant_1.id.to_s)
      expect(result['data']['type']).to eq('merchant')
    end
  end
end
