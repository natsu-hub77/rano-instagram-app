class FollowsController < ApplicationController
  before_action :authenticate_user!

  def create
    account = User.find(params[:account_id])
    current_user.follow!(params[:account_id])
  render json: { 
    status: 'followed',
    account_id: params[:account_id],
    followCount: account.follow_count
  }
  end
end