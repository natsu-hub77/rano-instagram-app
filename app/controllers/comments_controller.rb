class CommentsController < ApplicationController
  before_action :authenticate_user!

  def index
    post = Post.find(params[:post_id])
    comments = post.comments
    render json: comments
    # @post = Post.find(params[:post_id])
    # @comments = @post.comments
    @comment = Comment.new(user: current_user, post: @post)
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = Comment.new(comment_params.merge(user: current_user, post: @post))

    if @comment.save
      redirect_to post_comments_path(@post), notice: 'コメントを追加しました'
    else
      @comments = @post.comments
      flash.now[:error] = '更新できませんでした'
      render :index, status: :unprocessable_entity
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:content)
  end
end