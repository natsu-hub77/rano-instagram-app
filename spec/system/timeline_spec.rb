require 'rails_helper'

RSpec.describe 'Timeline', type: :system do
  let!(:user) { create(:user) }
  let!(:followed_user) { create(:user) }
  let!(:unfollowed_user) { create(:user) }

  context 'ログインしている場合' do
    before do
      sign_in user
      user.follow!(followed_user)

      create(:post, :with_images, user: followed_user, content: 'フォロー中の投稿')

      create(:post, :with_images, user: unfollowed_user, content: 'フォロー外の投稿')
      visit timeline_path
    end

    it 'フォロー中のユーザの投稿だけが表示される' do
      expect(page).to have_content('フォロー中の投稿')
      expect(page).not_to have_content('フォロー外の投稿')
    end
  end
end