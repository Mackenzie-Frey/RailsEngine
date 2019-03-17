require 'rails_helper'

describe 'Invoice Item API' do
  context 'Record Endpoint' do
    it 'sends a list of invoice_items' do
      create_list(:invoice_item, 3)

      get '/api/v1/invoice_items.json'

      expect(response).to be_successful

      result = JSON.parse(response.body)

      expect(result["data"].count).to eq(3)
      expect(result["data"].first).to have_key("id")
      expect(result["data"].first["type"]).to eq("invoice_item")
    end

    it 'sends a single transaction' do
      ii1 = create(:invoice_item)
      create_list(:invoice_item, 2)

      get "/api/v1/invoice_items/#{ii1.id}.json"

      expect(response).to be_successful

      result = JSON.parse(response.body)

      expect(result["data"]["id"]).to eq(ii1.id.to_s)
    end
  end

  context 'Single Finder' do
    it 'by ID' do
      create(:invoice_item)
      invoice_item_1 = create(:invoice_item)

      get "/api/v1/invoice_items/find?id=#{invoice_item_1.id}"

      result = JSON.parse(response.body)

      expect(result["data"]["id"]).to eq(invoice_item_1.id.to_s)
    end

    it 'by item_id' do
      item = create(:item)
      create(:invoice_item)
      invoice_item_1 = create(:invoice_item, item: item)

      get "/api/v1/invoice_items/find?item_id=#{item.id}"

      result = JSON.parse(response.body)

      expect(result["data"]["id"]).to eq(invoice_item_1.id.to_s)
    end

    it 'by invoice_id' do
      create(:invoice_item)
      invoice_item_2 = create(:invoice_item)

      get "/api/v1/invoice_items/find?invoice_id=#{invoice_item_2.invoice_id}"

      result = JSON.parse(response.body)

      expect(result["data"]["attributes"]["invoice_id"]).to eq(invoice_item_2.invoice_id)
    end

    it 'by quantity' do
      create(:invoice_item)
      invoice_item_1 = create(:invoice_item, quantity: 'success')

      get "/api/v1/invoice_items/find?quantity=#{invoice_item_1.quantity}"

      result = JSON.parse(response.body)

      expect(result["data"]["id"]).to eq(invoice_item_1.id.to_s)
    end

    it 'by unit_price' do
      unit_price = 100
      create(:invoice_item)
      invoice_item_1 = create(:invoice_item, unit_price: unit_price)

      get "/api/v1/invoice_items/find?unit_price=#{invoice_item_1.unit_price}"

      result = JSON.parse(response.body)

      expect(result["data"]["id"]).to eq(invoice_item_1.id.to_s)
    end

    it 'by created_at' do
      create(:invoice_item)
      invoice_item_1 = create(:invoice_item, created_at: "2012-03-27 14:53:59 UTC")

      get "/api/v1/invoice_items/find?created_at=#{invoice_item_1.created_at}"

      result = JSON.parse(response.body)

      expect(result["data"]["id"]).to eq(invoice_item_1.id.to_s)
    end

    it 'by updated_at' do
      create(:invoice_item)
      invoice_item_1 = create(:invoice_item, updated_at: "2012-03-27 14:53:59 UTC")

      get "/api/v1/invoice_items/find?updated_at=#{invoice_item_1.updated_at}"

      result = JSON.parse(response.body)

      expect(result["data"]["id"]).to eq(invoice_item_1.id.to_s)
    end
  end

  context 'Multi-Finders' do
    it 'by ID' do
      create(:invoice_item)
      invoice_item_1 = create(:invoice_item)

      get "/api/v1/invoice_items/find_all?id=#{invoice_item_1.id}"

      result = JSON.parse(response.body)

      expect(result["data"][0]["id"]).to eq(invoice_item_1.id.to_s)
    end

    it 'by item_id' do
      item = create(:item)
      create(:invoice_item)
      invoice_item_1 = create(:invoice_item, item: item)
      invoice_item_2 = create(:invoice_item, item: item)

      get "/api/v1/invoice_items/find_all?item_id=#{item.id}"

      result = JSON.parse(response.body)

      expect(result["data"].count).to eq(2)
      expect(result["data"][0]["id"]).to eq(invoice_item_1.id.to_s)
      expect(result["data"][1]["id"]).to eq(invoice_item_2.id.to_s)
    end

    it 'by invoice_id' do
      invoice = create(:invoice)
      create(:invoice_item)
      invoice_item_1 = create(:invoice_item, invoice: invoice)
      invoice_item_2 = create(:invoice_item, invoice: invoice)

      get "/api/v1/invoice_items/find_all?invoice_id=#{invoice.id}"

      result = JSON.parse(response.body)

      expect(result["data"].count).to eq(2)
      expect(result["data"][0]["attributes"]["invoice_id"]).to eq(invoice_item_1.invoice_id)
      expect(result["data"][0]["attributes"]["invoice_id"]).to eq(invoice_item_2.invoice_id)
    end

    it 'by quantity' do
      quantity = 10
      create(:invoice_item)
      invoice_item_1 = create(:invoice_item, quantity: quantity)
      invoice_item_2 = create(:invoice_item, quantity: quantity)

      get "/api/v1/invoice_items/find_all?quantity=#{quantity}"

      result = JSON.parse(response.body)

      expect(result["data"].count).to eq(2)
      expect(result["data"][0]["id"]).to eq(invoice_item_1.id.to_s)
      expect(result["data"][1]["id"]).to eq(invoice_item_2.id.to_s)
    end

    it 'by unit_price' do
      unit_price = 100
      create(:invoice_item)
      invoice_item_1 = create(:invoice_item, unit_price: unit_price)
      invoice_item_2 = create(:invoice_item, unit_price: unit_price)

      get "/api/v1/invoice_items/find_all?unit_price=#{unit_price}"

      result = JSON.parse(response.body)

      expect(result["data"].count).to eq(2)
      expect(result["data"][0]["id"]).to eq(invoice_item_1.id.to_s)
      expect(result["data"][1]["id"]).to eq(invoice_item_2.id.to_s)
    end

    it 'by created_at' do
      created_at = "2012-03-27"
      create(:invoice_item)
      invoice_item_1 = create(:invoice_item, created_at: created_at)
      invoice_item_2 = create(:invoice_item, created_at: created_at)

      get "/api/v1/invoice_items/find_all?created_at=#{created_at}"

      result = JSON.parse(response.body)

      expect(result["data"].count).to eq(2)
      expect(result["data"][0]["id"]).to eq(invoice_item_1.id.to_s)
      expect(result["data"][1]["id"]).to eq(invoice_item_2.id.to_s)
    end

    it 'by updated_at' do
      updated_at = "2012-03-27"
      create(:invoice_item)
      invoice_item_1 = create(:invoice_item, updated_at: updated_at)
      invoice_item_2 = create(:invoice_item, updated_at: updated_at)

      get "/api/v1/invoice_items/find_all?updated_at=#{updated_at}"

      result = JSON.parse(response.body)

      expect(result["data"].count).to eq(2)
      expect(result["data"][0]["id"]).to eq(invoice_item_1.id.to_s)
      expect(result["data"][1]["id"]).to eq(invoice_item_2.id.to_s)
    end
  end

  context 'Random' do
    it 'resource' do
      invoice_item_1 = create(:invoice_item)
      invoice_item_2 = create(:invoice_item)

      get '/api/v1/invoice_items/random.json'

      result = JSON.parse(response.body)
      expect(result["data"]["id"]).to eq(invoice_item_1.id.to_s).or eq(invoice_item_2.id.to_s)
    end
  end

  context 'Relationships' do
    it 'returns the associated invoice' do
      i1 = create(:invoice)
      i2 = create(:invoice)
      create(:invoice_item, invoice: i2)
      ii = create(:invoice_item, invoice: i1)

      get "/api/v1/invoice_items/#{ii.id}/invoice"

      result = JSON.parse(response.body)

      expect(result["data"]["id"]).to eq(i1.id.to_s)
    end

    it 'returns the associated item' do
      i1 = create(:item)
      i2 = create(:item)

      create(:invoice_item, item: i2)
      ii = create(:invoice_item, item: i1)

      get "/api/v1/invoice_items/#{ii.id}/item"
      
      result = JSON.parse(response.body)

      expect(result["data"]["id"]).to eq(i1.id.to_s)
    end
  end
end
