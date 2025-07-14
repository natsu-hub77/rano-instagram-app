class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def show
    @profile = current_user.profile
  end

  def update
    @profile = current_user.profile || current_user.build_profile
    if @profile.update(profile_params)
      avatar_url = url_for(@profile.avatar) if @profile.avatar.attached?
      render json: { status: 'OK', avatar_url: avatar_url }
    else
      render json: { status: 'NG', errors: @profile.errors.full_messages }, status: :unprocessable_entity
    end
  end


  private
  def profile_params
    params.require(:profile).permit(:avatar)
  end
end