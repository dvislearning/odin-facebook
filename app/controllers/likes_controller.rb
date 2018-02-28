class LikesController < ApplicationController
  
  def create
    @like = current_user.likes.build(likeable_id: params[:likeable_id], 
                                     likeable_type: params[:likeable_type])
    if @like.save
      flash[:notice] = "Post Liked"
    else
      flash[:notice] = "Cannot Like Post"
    end
    redirect_back(fallback_location: posts_path)
  end  
  
  def destroy
    @like = Like.find(params[:like_id])
    @like.destroy
    flash[:notice] = "Post Unliked"
    redirect_back(fallback_location: posts_path)
  end  
end
