class AccountsController < ApplicationController
  def show
    @user = User.find(params[:id])

    if @user == current_user
      redirect_to profile_path
    end

    respond_to do |format|
      format.html
      format.json do
        render json: {
          userId: @user.id,
          followers_count: @user.followers.count,
          has_followed: current_user.has_followed?(@user)
       }
      end
    end
  end
end