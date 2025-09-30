require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  let!(:user) { create(:user) }
  let!(:posts) { create_list(:post, 3, :with_images, user: user) }

  before do
    sign_in user
  end

  describe 'GET /' do
    it '200ステータスが返ってくる' do
      get root_path
      expect(response).to have_http_status(200)
    end
  end
end
