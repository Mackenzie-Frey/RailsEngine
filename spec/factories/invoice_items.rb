FactoryBot.define do
  factory :invoice_item do
    item { nil }
    invoice { nil }
    quantity { "" }
    unit_price { "MyString" }
    created_at { "MyString" }
    updated_at { "MyString" }
  end
end
