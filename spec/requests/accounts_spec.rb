require 'rails_helper'

RSpec.describe 'Accounts', type: :request do
  let!(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  
  describe 'GET /accounts' do
    context 'ログインしている場合' do
      before do
        sign_in user
      end

      it '自分のアカウントの場合はprofileにリダイレクトされる' do
        get account_path(user)
        expect(response).to redirect_to(profile_path)
      end

      it '他人のアカウントの場合は正常にユーザ情報を返す' do
        get account_path(other_user), as: :json
        expect(response).to have_http_status(200)
        body = JSON.parse(response.body)
        expect(body['userId']).to eq(other_user.id)
        expect(body['followers_count']).to eq(other_user.followers.count)
        expect(body['has_followed']).to eq(user.has_followed?(other_user))
      end
    end
  end
end
