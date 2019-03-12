FactoryBot.define do
  factory :invoice_item do
    item { nil }
    invoice { nil }
    quantity { 2 }
    unit_price { 10 }
    created_at { (Time.now - 1.day).utc }
    updated_at { (Time.now).utc }
  end
end
