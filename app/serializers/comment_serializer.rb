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
