require 'rails_helper'

RSpec.describe 'Api::Comments', type: :request do
  let!(:user) { create(:user) }
  let!(:my_post) { create(:post, :with_images, user: user) }
  let!(:comments) { create_list(:comment, 3, post: my_post, user: user) }

  describe 'GET /api/comments' do
    context 'ログインしている場合' do
      before do
        sign_in user
      end

      it '200 Status' do
        get post_comments_path(my_post), as: :json
        expect(response).to have_http_status(200)

        body = JSON.parse(response.body)
        expect(body.length).to eq 3
        expect(body[0]['content']).to eq comments.first.content
        expect(body[1]['content']).to eq comments.second.content
        expect(body[2]['content']).to eq comments.third.content
      end
    end
  end

  describe 'Post /api/comments' do
    context 'ログインしている場合' do
      before do
        sign_in user
      end

      it 'コメントが保存される' do
        comment_params = attributes_for(:comment)
        post post_comments_path(my_post), params: { comment: comment_params }, as: :json

        expect(response).to have_http_status(200)
        expect(Comment.last.content).to eq(comment_params[:content])
      end
    end
  end
end
