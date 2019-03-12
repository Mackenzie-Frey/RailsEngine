FactoryBot.define do
  factory :item do
    sequence :name { |n| "Stellar Item Name #{n}" }
    sequence :description { |n| "Item Description #{n}" }
    sequence :unit_price { |n| 100 + n }
    merchant { nil }
    created_at { (Time.now - 1.day).utc }
    updated_at { (Time.now).utc }
  end
end
