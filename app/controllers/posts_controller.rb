class PostsController < ApplicationController
  def index
  end

  def new
    @post = Post.new
  end


  private
  def post_params
    params.require(:post).permit(
      :content,
      :images
    )
  end
end