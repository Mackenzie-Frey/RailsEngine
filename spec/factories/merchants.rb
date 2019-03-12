FactoryBot.define do
  factory :merchant do
    name { "MyString" }
    created_at { (Time.now - 1.day).utc }
    updated_at { (Time.now).utc }
  end
end
