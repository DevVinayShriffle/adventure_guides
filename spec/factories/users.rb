# spec/factories/users.rb
FactoryBot.define do
  factory :user do
    name { "Test User" }
    email { "user@example.com" }
    password { "User@123" }
    password_confirmation { "User@123" }
  end
end
