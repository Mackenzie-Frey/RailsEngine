FactoryBot.define do
  factory :transaction do
    invoice { nil }
    credit_card_number { "92838383883" }
    credit_card_expiration { "" }
    result { "MyString" }
    created_at { (Time.now - 1.day).utc }
    updated_at { (Time.now).utc }
  end
end
