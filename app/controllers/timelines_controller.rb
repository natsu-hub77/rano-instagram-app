class TimelinesController <ApplicationController
  before_action :authenticate_user!

  def show
    user_ids = current_user.followings.pluck(:id)
    @posts = Post.where(user_id: user_ids)
                 .recent_24h
                 .with_like_count
                 .order("likes_count DESC, posts.created_at DESC")
                 .limit(5)
  end
end