class PostsController < ApplicationController
before_action :authenticate_user!

  def index
    @posts = Post.all.order(created_at: :desc)
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to root_path, notice: 'Successfully posted!'
    else
      flash.now[:error] = 'Failed to post'
      render :new, status: :unprocessable_entity
    end
  end

  private
  def post_params
    params.require(:post).permit(
      :content,
      images: []
    )
  end
end