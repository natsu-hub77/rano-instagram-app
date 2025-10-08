require 'rails_helper'

RSpec.describe 'Timelines', type: :request do
  let!(:user) { create(:user) }
  let!(:following1) { create(:user) }
  let!(:following2) { create(:user) }
  let!(:following3) { create(:user) }

  let!(:post1) { create(:post, :with_images, user: following1, created_at: 1.hour.ago) }
  let!(:post2) { create(:post, :with_images, user: following2, created_at: 2.hour.ago) }
  let!(:post3) { create(:post, :with_images, user: following3, created_at: 3.hour.ago) }
  let!(:post4) { create(:post, :with_images, user: following1, created_at: 25.hour.ago) }

  describe 'GET /timeline' do
    context 'ログインしている場合' do
      before do
        sign_in user
        user.follow!(following1.id)
        user.follow!(following2.id)
        user.follow!(following3.id)
        create_list(:like, 3, post: post1)
        create_list(:like, 1, post: post1)
        create_list(:like, 0, post: post1)
      end

      it 'フォローしている人の24時間以内の投稿でいいねしている数が多い投稿が表示される' do
        get timeline_path
        expect(response).to have_http_status(:ok)
        posts = controller.instance_variable_get(:@posts)
      end

      it '24時間よりも前の投稿は含まれないこと' do
        get timeline_path

        expect(response).to have_http_status(200)
        expect(response.body).not_to include(post4.content)
      end
    end
  end
end
