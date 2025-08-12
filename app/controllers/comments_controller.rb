class CommentsController < ApplicationController
  before_action :authenticate_user!

  def index
    @post = Post.find(params[:post_id])
    @comments = @post.comments
    # @comment = @post.comments.build
  end

  # def show
  #   @post = Post.find(prams[:post_id])
  #   @comments = @post.comments
  # end

  # def create
  #   @post = Post.find(params[:post_id])
  #   @comment = @post.comments.build(comment_params)
  #   @comment.user = current_user
  #   if @comment.save
  #     redirect_to post_comments_path(@post), notice: 'コメントを追加しました'
  #   else
  #     flash.now[:error] = '更新できませんでした'
  #     render :index, status: :unprocessable_entity
  #   end
  # end

  # private
  # def comment_params
  #   params.require(:comment).permit(:content)
  # end
end