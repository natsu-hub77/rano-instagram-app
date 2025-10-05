require 'rails_helper'

RSpec.describe 'Api::Unfollows', type: :request do
  let!(:follower) { create(:user) }
  let!(:account) { create(:user) }

  describe 'POST /api/unfollows' do
    context 'ログインしている場合'
      before do
        sign_in follower
        follower.follow!(account.id)
      end

    it 'フォローを解除できる' do
      post account_unfollows_path(account), as: :json

      expect(response).to have_http_status(200)
      body = JSON.parse(response.body)

      expect(body['status']).to eq('unfollowed')
      expect(body['account_id'].to_i).to eq(account.id)
      expect(account.reload.follow_count).to eq(0)
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
