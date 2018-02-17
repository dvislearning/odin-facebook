class PostsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @posts = current_user.timeline.paginate(page: params[:page])
    @post = current_user.posts.build
  end
  
  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:notice] = "Post Saved!"
      redirect_back(fallback_location: posts_path)
    else
      flash[:notice] = "Unable to Save Post"
      redirect_back(fallback_location: posts_path)
    end
  end
  
  def destroy
    @post = current_user.posts.find_by(id: params[:id])
    @post.destroy
    flash[:success] = "Post deleted"
    redirect_back(fallback_location: posts_path)
  end
  
  private

    def post_params
      params.require(:post).permit(:content)
    end  
end
