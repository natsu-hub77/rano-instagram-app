# == Schema Information
#
# Table name: posts
#
#  id         :bigint           not null, primary key
#  content    :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_posts_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Post < ApplicationRecord
  validates :content, presence: true
  validate :must_have_at_least_one_image

  belongs_to :user
  has_many_attached :images

  def must_have_at_least_one_image
    if images.blank?
      errors.add(:base, '画像を1枚以上アップロードしてください') 
    end
  end
end
