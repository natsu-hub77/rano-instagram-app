# == Schema Information
#
# Table name: comments
#
#  id         :bigint           not null, primary key
#  content    :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  post_id    :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_comments_on_post_id  (post_id)
#  index_comments_on_user_id  (user_id)
#
class CommentSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :id, :content, :account_name, :avatar_url

  def account_name
    object.user.account_name
  end

  def avatar_url
    url_for(object.user.profile.avatar) if object.user&.profile&.avatar&.attached?
  end
end
