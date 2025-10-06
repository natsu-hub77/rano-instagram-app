require 'rails_helper'

RSpec.describe 'Api::Likes', type: :request do
  let!(:user) { create(:user) }
  let!(:posts) { create_list(:post, 3, :with_images, user: user) }

  describe 'GET /api/likes' do
    context 'ログインしている場合' do
      before do
        sign_in user
      end

      it 'それぞれの投稿について like 状態を確認できる' do
        posts.first.likes.create!(user: user)

        get post_like_path(posts.first), as: :json
        body = JSON.parse(response.body)
        expect(body['hasLiked']).to eq(true)

        get post_like_path(posts.second), as: :json
        body = JSON.parse(response.body)
        expect(body['hasLiked']).to eq(false)

        get post_like_path(posts.third), as: :json
        body = JSON.parse(response.body)
        expect(body['hasLiked']).to eq(false)
      end
    end
  end
end
