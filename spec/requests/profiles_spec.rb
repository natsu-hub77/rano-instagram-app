require 'rails_helper'

RSpec.describe 'Profiles', type: :request do
  let!(:user) { create(:user) }

  describe 'GET /profile' do
    context 'ログインしている場合' do
      before do 
        sign_in user
      end

      it '自分のプロフィール画面を表示できる' do
        get profile_path

        expect(response).to have_http_status(200)
        expect(response.body).to include(:user.name)
      end
    end

    context 'ログインしていない場合' do
      it 'ログインページにリダイレクトされる' do
        get profile_path

        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'PUT / profile' do
    context 'ログインしている場合' do
      before do
        sign_in user
      end

      it '新しい画像をアップロードできる' do
        avatar = fixture_file_upload(Rails.root.join('spec/fixtures/files/test.jpeg'))

        put profile_path, params: { profile: { avatar: avatar} }

        expect(response).to have_http_status(:ok)
        body = JSON.parse(response.body)
        expect(body['status']).to eq('OK')
        expect(user.reload.profile.avatar).to be_attached
      end
    end
  end

end
