require 'rails_helper'

RSpec.describe Merchant, type: :model do
  context 'Realtionships' do
    it { should have_many(:invoices) }
    it { should have_many(:items) }
  end

  context 'Validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:created_at) }
    it { should validate_presence_of(:updated_at) }
  end

  context 'Class Methods' do
    it '#most_revenue' do
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

      expect(Merchant.most_revenue(2)).to eq([merchant_2, merchant_1])
    end
  end
end
