require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  let!(:user) { create(:user) }
  let!(:posts) { create_list(:post, 3, :with_images, user: user) }

  describe 'GET /' do

    before do
      sign_in user
    end

    it '200ステータスが返ってくる' do
      get root_path
      expect(response).to have_http_status(200)
    end
  end

  describe 'Post /posts' do
    context 'ログインしている場合' do
      before do
        sign_in user
      end
  
      it '記事が保存される(画像必須)' do
      post_params = attributes_for(:post)
      file = fixture_file_upload(Rails.root.join('spec/fixtures/files/test.jpeg'), 'image/jpeg')
      post posts_path, params: { post: post_params.merge(images: [file]) }

      expect(response).to have_http_status(302)
      expect(Post.last.content).to eq(post_params[:content])
      expect(Post.last.images).to be_attached
      end
    end

    context 'ログインしていない場合' do
      it 'ログイン画面にリダイレクトされる' do
        post_params = attributes_for(:post)
        file = fixture_file_upload(Rails.root.join('spec/fixtures/files/test.jpeg'), 'image/jpeg')
        post posts_path, params: { post: post_params.merge(images: [file]) }

        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
