require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  context "Realtionships" do
    it { should belong_to(:item) }
    it { should belong_to(:invoice) }
  end

  context "Validations" do
    it { should validate_presence_of(:quantity) }
    it { should validate_presence_of(:unit_price) }
    it { should validate_presence_of(:created_at) }
    it { should validate_presence_of(:updated_at) }
  end
end
