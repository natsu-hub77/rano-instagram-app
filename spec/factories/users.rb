FactoryBot.define do
  factory :user do
    account_name { Faker::Lorem.characters(number: 7) }
    email { Faker::Internet.email }
    password { 'password' }

  end
end