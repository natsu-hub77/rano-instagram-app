require 'rails_helper'

RSpec.describe 'Api::Follows', type: :request do
  let!(:follower) { create(:user) } #フォローする側
  let!(:account) { create(:user) } #フォローされる側

  describe 'GET /api/follows' do
    context 'ログインしている場合' do
      before do
        sign_in follower
      end

      it 'ユーザをフォローできる' do
        post account_follows_path(account), as: :json

        expect(response).to have_http_status(200)
        body = JSON.parse(response.body)

        expect(body['status']).to eq('followed')
        expect(body['account_id'].to_i).to eq(account.id)
        expect(account.reload.follow_count).to eq(1)
      end
    end

    context 'ログインしていない場合' do
      it '401が返る' do
        post account_follows_path(account), as: :json

        expect(response).to have_http_status(:unauthorized)
        body = JSON.parse(response.body)
        expect(body['error']).to be_present
      end
    end
  end
end
