class PostsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @posts = current_user.timeline.paginate(page: params[:page])
  end
  
  def create
  end
  
  def destroy
  end
end
