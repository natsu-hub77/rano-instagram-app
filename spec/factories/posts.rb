FactoryBot.define do
  factory :post do
    content { Faker::Lorem.characters(number: 50) }

    trait :with_images do
      after(:build) do |post|
        post.images.attach(
          io: File.open(Rails.root.join('spec/fixtures/files/test.jpeg')),
          filename: 'test.jpeg',
          content_type: 'image/jpeg'
        )
        post.images.attach(
          io: File.open(Rails.root.join('spec/fixtures/files/test2.jpeg')),
          filename: 'test2.jpeg',
          content_type: 'image/jpeg'
        )
      end
    end

    trait :with_comments do
      after(:build) do |post|
        other_user = create(:user)
        create_list(:comment, 3, post: post, user: other_user)
      end
    end
  end
end