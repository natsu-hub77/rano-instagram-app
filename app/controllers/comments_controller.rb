class CommentsController < ApplicationController
  before_action :authenticate_user!

  def index
    @post = Post.find(params[:post_id])
    @comments = @post.comments
    @comment = Comment.new(user: current_user, post: @post)
    respond_to do |format|
      format.html
      format.json { render json: @comments }
    end
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = Comment.new(comment_params.merge(user: current_user, post: @post))
    @comment.save!

    render json: @comment
  end

  def edit
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
  end 

  private
  def comment_params
    params.require(:comment).permit(:content)
  end
end