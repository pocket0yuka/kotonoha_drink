FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user_#{n}@example.com" }
    password {"password"}
    encrypted_password {"password"}
    name {"test"}
  end
end
