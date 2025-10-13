require 'rails_helper'

RSpec.describe 'Comment', type: :system do
  let!(:user) { create(:user) }
  let!(:post) { create(:post, :with_images, :with_comments, user: user) }

  context 'ログインしている場合' do
    before do
      sign_in user
    end

    it 'コメント一覧が非同期で表示される' do
      visit post_comments_path(post)

      # コメントが非同期で描画されるまで待つ
      expect(page).to have_css('.comments-container', visible: :all, wait: 15)

      # コメントの要素が出るまで待つ
      expect(page).to have_css('.comment-post', minimum: post.comments.count, wait: 15)

      # 内容を確認
      post.comments.each do |comment|
        expect(page).to have_text(comment.content, wait: 15)
      end
    end
  end
end
