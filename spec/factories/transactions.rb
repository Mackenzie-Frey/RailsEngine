FactoryBot.define do
  factory :transaction do
    invoice
    sequence :credit_card_number { |n| "92838383883#{n}" }
    credit_card_expiration_date { "" }
    result { nil }
    created_at { (Time.now - 1.day).utc }
    updated_at { (Time.now).utc }
  end
end
