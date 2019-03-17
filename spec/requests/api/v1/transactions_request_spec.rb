require 'rails_helper'

describe 'Transaction API' do
  context 'Record Endpoint' do
    it 'sends a list of transactions' do
      create(:transaction, result: "success")
      create(:transaction, result: "failed")
      create(:transaction, result: "success")

      get '/api/v1/transactions.json'

      expect(response).to be_successful

      result = JSON.parse(response.body)

      expect(result["data"].count).to eq(3)
      expect(result["data"].first).to have_key("id")
      expect(result["data"].first["type"]).to eq("transaction")
    end

    it 'sends a single transaction' do
      t1 = create(:transaction)
      create_list(:transaction, 2)

      get "/api/v1/transactions/#{t1.id}.json"

      expect(response).to be_successful

      result = JSON.parse(response.body)

      expect(result["data"]["id"]).to eq(t1.id.to_s)
    end
  end

  context 'Single Finder' do
    it 'by ID' do
      create(:transaction)
      transaction_1 = create(:transaction)

      get "/api/v1/transactions/find?id=#{transaction_1.id}"

      result = JSON.parse(response.body)

      expect(result["data"]["id"]).to eq(transaction_1.id.to_s)
    end

    it 'by invoice_id' do
      create(:transaction)
      transaction_1 = create(:transaction)

      get "/api/v1/transactions/find?invoice_id=#{transaction_1.invoice_id}"

      result = JSON.parse(response.body)

      expect(result["data"]["id"]).to eq(transaction_1.id.to_s)
    end

    it 'by credit_card_number' do
      create(:transaction)
      transaction_2 = create(:transaction)

      get "/api/v1/transactions/find?credit_card_number=#{transaction_2.credit_card_number}"

      result = JSON.parse(response.body)

      expect(result["data"]["attributes"]["credit_card_number"]).to eq(transaction_2.credit_card_number)
    end

    it 'by result' do
      create(:transaction)
      transaction_1 = create(:transaction, result: 'success')

      get "/api/v1/transactions/find?result=#{transaction_1.result}"

      result = JSON.parse(response.body)

      expect(result["data"]["id"]).to eq(transaction_1.id.to_s)
    end

    it 'by created_at' do
      create(:transaction)
      transaction_1 = create(:transaction, created_at: "2012-03-27 14:53:59 UTC")

      get "/api/v1/transactions/find?created_at=#{transaction_1.created_at}"

      result = JSON.parse(response.body)

      expect(result["data"]["id"]).to eq(transaction_1.id.to_s)
    end

    it 'by updated_at' do
      create(:transaction)
      transaction_1 = create(:transaction, updated_at: "2012-03-27 14:53:59 UTC")

      get "/api/v1/transactions/find?updated_at=#{transaction_1.updated_at}"

      result = JSON.parse(response.body)

      expect(result["data"]["id"]).to eq(transaction_1.id.to_s)
    end
  end

  context 'Multi-Finders' do
    it 'by ID' do
      create(:transaction)
      transaction_1 = create(:transaction)

      get "/api/v1/transactions/find_all?id=#{transaction_1.id}"

      result = JSON.parse(response.body)

      expect(result["data"][0]["id"]).to eq(transaction_1.id.to_s)
    end

    it 'by invoice_id' do
      invoice = create(:invoice)
      create(:transaction)
      transaction_1 = create(:transaction, invoice: invoice)
      transaction_2 = create(:transaction, invoice: invoice)

      get "/api/v1/transactions/find_all?invoice_id=#{invoice.id}"

      result = JSON.parse(response.body)

      expect(result["data"][0]["id"]).to eq(transaction_1.id.to_s)
      expect(result["data"][1]["id"]).to eq(transaction_2.id.to_s)
    end

    it 'by credit_card_number' do
      credit_card_number = "234982349823"
      create(:transaction, credit_card_number: credit_card_number)
      create(:transaction, credit_card_number: credit_card_number)
      create(:transaction)

      get "/api/v1/transactions/find_all?credit_card_number=#{credit_card_number}"

      result = JSON.parse(response.body)

      expect(result["data"].count).to eq(2)

      expect(result["data"][0]["attributes"]["credit_card_number"]).to eq(credit_card_number)
      expect(result["data"][1]["attributes"]["credit_card_number"]).to eq(credit_card_number)
    end

    it 'by result' do
      result1 = 'success'
      create(:transaction, result: result1)
      create(:transaction, result: result1)
      create(:transaction, result: 'failed')

      get "/api/v1/transactions/find_all?result=#{result1}"

      result = JSON.parse(response.body)

      expect(result["data"].count).to eq(2)

      expect(result["data"][0]["attributes"]["result"]).to eq(result1)
      expect(result["data"][1]["attributes"]["result"]).to eq(result1)
    end

    xit 'by created_at' do
      created_at = "2012-03-27"
      t1 = create(:transaction, created_at: created_at)
      t2 = create(:transaction, created_at: created_at)
      create(:transaction)

      get "/api/v1/transactions/find_all?created_at=#{created_at}"

      result = JSON.parse(response.body)

      expect(result["data"].count).to eq(2)

      expect(result["data"][0]["attributes"]["created_at"]).to eq(t1.created_at)
      expect(result["data"][1]["attributes"]["created_at"]).to eq(t2.created_at)
    end

    xit 'by updated_at' do
      updated_at = "2012-03-27"
      t1 = create(:transaction, updated_at: updated_at)
      t2 = create(:transaction, updated_at: updated_at)
      create(:transaction)

      get "/api/v1/transactions/find_all?updated_at=#{updated_at}"

      result = JSON.parse(response.body)

      expect(result["data"].count).to eq(2)

      expect(result["data"][0]["attributes"]["updated_at"]).to eq(t1.updated_at)
      expect(result["data"][1]["attributes"]["updated_at"]).to eq(t2.updated_at)
    end
  end

  context 'Random' do
    it 'resource' do
      transaction_1 = create(:transaction)
      transaction_2 = create(:transaction)

      get '/api/v1/transactions/random.json'

      result = JSON.parse(response.body)
      expect(result["data"]["id"]).to eq(transaction_1.id.to_s).or eq(transaction_2.id.to_s)
    end
  end

  context 'Relationships' do
    it 'returns the associated invoice' do
      invoice_1 = create(:invoice)
      invoice_2 = create(:invoice)

      create(:transaction, invoice: invoice_1)
      transaction_2 = create(:transaction, invoice: invoice_2)

      get "/api/v1/transactions/#{transaction_2.id}/invoice"

      result = JSON.parse(response.body)
      expect(result["data"]["id"]).to eq(invoice_2.id.to_s)
    end
  end
end
