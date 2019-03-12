FactoryBot.define do
  factory :item do
    name { "Stella Item Name" }
    description { "Item Description" }
    unit_price { 100 }
    merchant { nil }
    created_at { (Time.now - 1.day).utc }
    updated_at { (Time.now).utc }
  end
end
