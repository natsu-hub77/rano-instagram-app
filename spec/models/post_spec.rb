require 'rails_helper'

RSpec.describe Post, type: :model do
  context 'contentが入力されていて画像がアップロードされていれば' do
    before do
      user = User.create!({
      account_name: 'test',
      email: 'test@example.com',
      password: 'password'
      })
      @post = user.posts.build({
        content: Faker::Lorem.characters(number: 50)
      })

      @post.images.attach(
        {
          io: File.open(Rails.root.join('spec/fixtures/files/test.jpeg')),
          filename: 'test.jpeg',
          content_type: 'image/jpeg'
        },
        {
          io: File.open(Rails.root.join('spec/fixtures/files/test2.jpeg')),
          filename: 'test2.jpeg',
          content_type: 'image/jpeg'
        }
      )
    end
    it '投稿を保存できる' do

    expect(@post).to be_valid
  end
  end
end
