class CommentsController < ApplicationController
  before_action :authenticate_user!
  
  
  def create
    @comment = current_user.comments.build(comment_params)
    if @comment.save
      flash[:notice] = "Comment Added!"
      redirect_back(fallback_location: posts_path)
    else
      flash[:notice] = "Unable to Save comment"
      redirect_back(fallback_location: posts_path)
    end
  end
  
  def update
  end
  
  def destroy
    @comment = current_user.comments.find_by(id: params[:id])
    @comment.destroy
    flash[:success] = "comment deleted"
    redirect_back(fallback_location: posts_path)
  end
  
  private

    def comment_params
      params.require(:comment).permit(:content, :commentable_id, :commentable_type)
    end  
end
