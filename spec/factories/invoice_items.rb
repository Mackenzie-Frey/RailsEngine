FactoryBot.define do
  factory :invoice_item do
    item { nil }
    invoice { nil }
    sequence :quantity { |n| 2 + n }
    sequence :unit_price { |n| 10 + n }
    created_at { (Time.now - 1.day).utc }
    updated_at { (Time.now).utc }
  end
end
