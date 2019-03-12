FactoryBot.define do
  factory :merchant do
    sequence :name { |n| "Most Interesting Merchant #{n}" }
    created_at { (Time.now - 1.day).utc }
    updated_at { (Time.now).utc }
  end
end
