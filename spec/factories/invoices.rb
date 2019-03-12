FactoryBot.define do
  factory :invoice do
    customer { nil }
    merchant { nil }
    status { "MyString" }
    created_at { "MyString" }
    updated_at { "MyString" }
  end
end
