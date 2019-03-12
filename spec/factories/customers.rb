FactoryBot.define do
  factory :customer do
    sequence :first_name { |n| "Sally #{n}" }
    sequence :last_name { |n| "Ride #{n}" }
    created_at { (Time.now - 1.day).utc }
    updated_at { (Time.now).utc }
  end
end
