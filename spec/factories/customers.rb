FactoryBot.define do
  factory :customer do
    first_name { "MyString" }
    last_name { "MyString" }
    created_at { (Time.now - 1.day).utc }
    updated_at { (Time.now).utc }
  end
end
