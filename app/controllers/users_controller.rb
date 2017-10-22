class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
  end

  def index
    @users = User.all.paginate(page: params[:page])
  end
  
  def pending
    @pending_friends = current_user.received_requests.pending.all
  end  
end
