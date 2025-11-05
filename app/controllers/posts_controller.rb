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

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    update_params = post_params.dup

    # images が存在していて、かつ中身が空文字 or 空配列なら削除
    if update_params[:images].present? && update_params[:images].all?(&:blank?)
      update_params.delete(:images)
    end

    if @post.update(update_params)
      redirect_to profile_path, notice: 'Updated successfully'
    else
      flash.now[:error] = 'Update failed'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy!
    redirect_to profile_path, status: :see_other, notice: 'Deleted successfully'
  end

  private
  def post_params
    params.require(:post).permit(
      :content,
      images: []
    )
  end
end