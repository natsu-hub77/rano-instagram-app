FactoryBot.define do
  factory :comment do
    content { Faker::Lorem.characters(number: 70) }
  end
end
