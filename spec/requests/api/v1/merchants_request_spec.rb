require 'rails_helper'

describe 'Merchant API' do
  context 'Record Endpoint' do
    it 'sends a list of merchants' do
      create_list(:merchant, 3)

      get '/api/v1/merchants.json'

      expect(response).to be_successful

      merchants = JSON.parse(response.body)

      expect(merchants["data"].count).to eq(3)
      expect(merchants["data"].first).to have_key("id")
      expect(merchants["data"].first["type"]).to eq("merchant")
      expect(merchants["data"].first["attributes"]["name"]).to eq(Merchant.first.name)
    end

    it 'sends a single merchant' do
      m1 = create(:merchant)
      create_list(:merchant, 2)

      get "/api/v1/merchants/#{m1.id}.json"

      expect(response).to be_successful

      merchants = JSON.parse(response.body)

      expect(merchants["data"]["id"]).to eq(m1.id.to_s)
      expect(merchants["data"]["attributes"]["name"]).to eq(m1.name)
    end
  end

  context 'Single Finder' do
    it 'by ID' do
      create(:merchant)
      merchant_1 = create(:merchant)

      get "/api/v1/merchants/find?id=#{merchant_1.id}"

      result = JSON.parse(response.body)

      expect(result["data"]["id"]).to eq(merchant_1.id.to_s)
    end

    it 'by name' do
      create(:merchant)
      merchant_1 = create(:merchant)

      get "/api/v1/merchants/find?name=#{merchant_1.name}"

      result = JSON.parse(response.body)

      expect(result["data"]["attributes"]["name"]).to eq(merchant_1.name)
    end

    it 'by created_at' do
      create(:merchant)
      merchant_1 = create(:merchant, created_at: "2012-03-27 14:53:59 UTC")

      get "/api/v1/merchants/find?created_at=#{merchant_1.created_at}"

      result = JSON.parse(response.body)

      expect(result["data"]["id"]).to eq(merchant_1.id.to_s)
    end

    it 'by updated_at' do
      create(:merchant)
      merchant_1 = create(:merchant, updated_at: "2012-03-27 14:53:59 UTC")

      get "/api/v1/merchants/find?updated_at=#{merchant_1.updated_at}"

      result = JSON.parse(response.body)

      expect(result["data"]["id"]).to eq(merchant_1.id.to_s)
    end
  end

  context 'Multi-Finders' do
    it 'by id' do
      create(:merchant)
      merchant = create(:merchant)

      get "/api/v1/merchants/find_all?id=#{merchant.id}"

      result = JSON.parse(response.body)

      expect(result["data"][0]["id"]).to eq(merchant.id.to_s)
    end

    it 'by name' do
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

    it 'by created_at' do
      create(:merchant)
      merchant_1 = create(:merchant, created_at: "2012-03-27 14:53:59 UTC")
      merchant_2 = create(:merchant, created_at: "2012-03-27 14:53:59 UTC")

      get "/api/v1/merchants/find_all?created_at=2012-03-27 14:53:59 UTC"

      result = JSON.parse(response.body)

      expect(result["data"].count).to eq(2)
      expect(result["data"][0]["id"]).to eq(merchant_1.id.to_s)
      expect(result["data"][1]["id"]).to eq(merchant_2.id.to_s)
    end

    it 'by updated_at' do
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
    it 'resource' do
      merchant_1 = create(:merchant)
      merchant_2 = create(:merchant)

      get '/api/v1/merchants/random.json'

      result = JSON.parse(response.body)
      expect(result["data"]["id"]).to eq(merchant_1.id.to_s).or eq(merchant_2.id.to_s)
    end
  end

  context 'Relationships' do
    it 'returns a collection of items associated with that merchant' do
      create(:merchant)
      merchant = create(:merchant)

      create(:item, merchant: merchant)
      create(:item, merchant: merchant)

      get "/api/v1/merchants/#{merchant.id}/items"

      result = JSON.parse(response.body)

      expect(result['data'].count).to eq(2)
      expect(result['data'][0]['attributes']['merchant_id']).to eq(merchant.id)
      expect(result['data'][0]['type']).to eq('item')
    end

    it 'returns a collection of invoices associated with that merchant from their known orders' do
      customer = create(:customer)
      merchant_1 = create(:merchant)
      merchant_2 = create(:merchant)

      create(:invoice, merchant: merchant_1, customer: customer)
      create(:invoice, merchant: merchant_1, customer: customer)
      create(:invoice, merchant: merchant_2, customer: customer)

      get "/api/v1/merchants/#{merchant_1.id}/invoices"

      result = JSON.parse(response.body)

      expect(result['data'].count).to eq(2)
      expect(result['data'][0]['attributes']['merchant_id']).to eq(merchant_1.id)
      expect(result['data'][0]['type']).to eq('invoice')
    end
  end

  context 'Business Intelligence' do
    context 'all merchants' do
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

        expect(result["data"].count).to eq(2)
        expect(result["data"][0]["id"]).to eq(merchant_2.id.to_s)
        expect(result["data"][1]["id"]).to eq(merchant_1.id.to_s)
      end

      it 'returns the top x merchants ranked by total number of items sold' do
        merchant_1 = create(:merchant)
        merchant_2 = create(:merchant)
        merchant_3 = create(:merchant)

        invoice_1 = create(:invoice, merchant: merchant_1)
        invoice_2 = create(:invoice, merchant: merchant_2)
        invoice_3 = create(:invoice, merchant: merchant_3)

        create(:invoice_item, invoice: invoice_1, quantity: 10, unit_price: 500)
        create(:invoice_item, invoice: invoice_2, quantity: 20, unit_price: 500)
        create(:invoice_item, invoice: invoice_2, quantity: 20, unit_price: 500)
        create(:invoice_item, invoice: invoice_3, quantity: 30, unit_price: 500)

        create(:transaction, invoice: invoice_1, result: "success")
        create(:transaction, invoice: invoice_2, result: "success")
        create(:transaction, invoice: invoice_3, result: "failed")

        get '/api/v1/merchants/most_items?quantity=2'

        result = JSON.parse(response.body)

        expect(result["data"].count).to eq(2)
        expect(result["data"][0]["id"]).to eq(merchant_2.id.to_s)
        expect(result["data"][1]["id"]).to eq(merchant_1.id.to_s)
      end

      it 'returns the total revenue for date x across all merchants' do
        merchant_1 = create(:merchant)
        merchant_2 = create(:merchant)
        merchant_3 = create(:merchant)

        invoice_1 = create(:invoice, merchant: merchant_1, updated_at: "2012-03-29 14:53:59 UTC")
        invoice_2 = create(:invoice, merchant: merchant_2, updated_at: "2012-03-27 14:53:59 UTC")
        invoice_3 = create(:invoice, merchant: merchant_3, updated_at: "2012-03-27 14:53:59 UTC")

        create(:invoice_item, invoice: invoice_1, quantity: 10, unit_price: 500)
        create(:invoice_item, invoice: invoice_2, quantity: 2, unit_price: 50)
        create(:invoice_item, invoice: invoice_2, quantity: 2, unit_price: 50)
        create(:invoice_item, invoice: invoice_3, quantity: 2, unit_price: 50)

        create(:transaction, invoice: invoice_1, result: "success")
        create(:transaction, invoice: invoice_2, result: "success")
        create(:transaction, invoice: invoice_3, result: "success")
        create(:transaction, invoice: invoice_3, result: "failed")

        get '/api/v1/merchants/revenue?date=2012-03-27'

        result = JSON.parse(response.body)

        expect(result["data"]["attributes"]["total_revenue"]).to eq('3.00')
      end
    end

    context 'single merchant' do
      it 'returns total revenue for a single merchant by invoice date' do
        merchant = create(:merchant)
        other_merchant = create(:merchant)

        invoices = []
        invoices << create(:invoice, merchant: merchant, updated_at: "2012-03-25 12:54:09 UTC")
        invoices << create(:invoice, merchant: merchant, updated_at: "2012-03-25 06:12:20 UTC")
        invoices << create(:invoice, merchant: merchant, updated_at: "2013-03-25 09:54:09 UTC")
        failed_invoices = create_list(:invoice, 3, merchant: merchant, updated_at: "2012-03-25 09:54:09 UTC")
        other_invoices = create_list(:invoice, 3, merchant: other_merchant, updated_at: "2012-03-25 09:54:09 UTC")

        counter = 0
        3.times do
          create(:invoice_item, invoice: invoices[counter], quantity: 5, unit_price: 5000)
          create(:transaction, result: 'success', invoice: invoices[counter])
          create(:transaction, result: 'failed', invoice: failed_invoices[counter])

          create(:invoice_item, invoice: other_invoices[counter], quantity: 5, unit_price: 5000)
          create(:transaction, result: 'success', invoice: other_invoices[counter])

          counter += 1
        end

        get "/api/v1/merchants/#{merchant.id}/revenue?date=2012-03-25"

        json = JSON.parse(response.body)

        expect(json['data']['attributes']['revenue']).to eq('500.00')
      end

      it 'returns the customer who has conducted the most total number of successful transactions' do
        create(:merchant)
        merchant = create(:merchant)
        customer_1 = create(:customer)
        customer_2 = create(:customer)
        customer_3 = create(:customer)

        invoice_1 = create(:invoice, customer: customer_1)
        invoice_2 = create(:invoice, merchant: merchant, customer: customer_2)
        invoice_3 = create(:invoice, merchant: merchant, customer: customer_3)
        invoice_4 = create(:invoice, merchant: merchant, customer: customer_3)

        create(:transaction, invoice: invoice_1, result: "success")
        create(:transaction, invoice: invoice_2, result: "success")
        create(:transaction, invoice: invoice_2, result: "failed")
        create(:transaction, invoice: invoice_3, result: "success")
        create(:transaction, invoice: invoice_4, result: "success")

        get "/api/v1/merchants/#{merchant.id}/favorite_customer"

        result = JSON.parse(response.body)

        expect(result['data']['attributes']['id']).to eq(customer_3.id)
      end
    end
  end
end
