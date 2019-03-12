FactoryBot.define do
  factory :customer do
    first_name { "Sally" }
    last_name { "Ride" }
    created_at { (Time.now - 1.day).utc }
    updated_at { (Time.now).utc }
  end
end
