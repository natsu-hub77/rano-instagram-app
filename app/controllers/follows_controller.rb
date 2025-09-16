class FollowsController < ApplicationController
  before_action :authenticate_user!

  def create
    current_user.follow!(params[:account_id])
  render json: { status: 'followed', account_id: params[:account_id] }
  end
end