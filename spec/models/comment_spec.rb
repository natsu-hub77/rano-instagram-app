require 'rails_helper'

RSpec.describe Comment, type: :model do

  let!(:user) { create(:user) }

   context 'contentが入力されていれば' do
    let!(:comment) { create(:user) }

    it '保存できる' do
      expect(comment).to be_valid
    end

    context 'contentが未入力の場合' do
      let!(:comment) { build(:comment, user: user, content:'' )}

      before do
        comment.save
      end

      it 'コメントを保存できない' do
        expext(comment.errors.messages[:content][0]).to eq('を入力してください')
      end
    end
  end
end
