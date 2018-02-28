class PicturesController < ApplicationController
  before_action :authenticate_user!
  
  
  # Create action reflects requirement that user is "none the wiser"
  # that his post is actually saved as a picture object 
  def create
    @picture = current_user.pictures.build(picture_params)
    if @picture.save
      flash[:notice] = "Post Saved!"
      redirect_back(fallback_location: posts_path)
    else
      flash[:notice] = "Unable to Save Post"
      redirect_back(fallback_location: posts_path)
    end
  end
  
  def destroy
    @picture = current_user.pictures.find_by(id: params[:id])
    @picture.destroy
    flash[:success] = "Post deleted"
    redirect_back(fallback_location: posts_path)
  end
  
  private
  
    def picture_params
      params.require(:picture).permit(:image)
    end    
end
