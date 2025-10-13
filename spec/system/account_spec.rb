require 'rails_helper'

RSpec.describe 'Account', type: :system do
  let!(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:posts) { create_list(:post, 3, :with_images, user: other_user) }

  context 'ログインしている場合' do
    before do
      sign_in user
    end

    it '他人の投稿したポストのアイコンをクリックしたら他人のプロフィール画面が表示される' do
      visit root_path

      first(".icon a").click
      expect(current_path).to eq account_path(other_user)
      expect(page).to have_content other_user.account_name
      expect(page).to have_selector('.follow-btn', text: 'Follow', visible: :all)
    end
  end
end