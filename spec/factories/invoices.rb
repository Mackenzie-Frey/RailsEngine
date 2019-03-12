FactoryBot.define do
  factory :invoice do
    customer
    merchant
    status { "shipped" }
    created_at { (Time.now - 1.day).utc }
    updated_at { (Time.now).utc }
  end
end
