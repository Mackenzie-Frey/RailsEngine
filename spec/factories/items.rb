FactoryBot.define do
  factory :item do
    name { "MyString" }
    description { "MyString" }
    unit_price { "MyString" }
    merchant { nil }
    created_at { (Time.now - 1.day).utc }
    updated_at { (Time.now).utc }
  end
end
