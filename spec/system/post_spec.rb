require 'rails_helper'

RSpec.describe 'Post', type: :system do
  let!(:user) { create(:user) }
  let!(:posts) { create_list(:post, 3, :with_images, user: user) }

  context 'ログインしている場合' do

    before do
      sign_in user
    end

    it '投稿一覧が表示される' do
      visit root_path
      posts.each do |post|
        expect(page).to have_content(post.content)
      end
    end
  end
end