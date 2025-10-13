require 'rails_helper'

RSpec.describe 'Profile', type: :system do
  let!(:user) { create(:user) }
  let!(:posts) { create_list(:post, 3, :with_images, user: user) }

  context 'ログインしている場合' do
    before do
      sign_in user
    end

    it '自分の投稿したポストのアイコンをクリックしたら自分のプロフィール画面が表示される' do
      visit root_path

      first(".icon a").click
      expect(current_path).to eq profile_path
      expect(page).to have_content user.account_name
    end
  end
end