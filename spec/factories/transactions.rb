FactoryBot.define do
  factory :transaction do
    invoice { nil }
    credit_card_number { "MyString" }
    credit_card_expiration { "MyString" }
    result { "MyString" }
    created_at { (Time.now - 1.day).utc }
    updated_at { (Time.now).utc }
  end
end
