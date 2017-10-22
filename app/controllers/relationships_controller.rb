class RelationshipsController < ApplicationController

  def create
    @friendship = current_user.sent_requests.build(receiver_id: params[:receiver_id])
    if @friendship.save
      flash[:notice] = "Friend Request Sent"
      redirect_to root_url
    else
      flash[:notice] = "Unable to Add Friend"
      redirect_to root_url
    end
  end
  
  def update
    @friendship = Relationship.find(params[:relationship_id])
    @friendship.update_attribute(:confirmed_friends,    true)
    flash[:notice] = "Friendship Confirmed!"
    redirect_to pending_path
  end
  
  def destroy
    @friendship = Relationship.find(params[:relationship_id])
    @friendship.destroy
    flash[:notice] = "Friendship Deleted"
    redirect_to current_user
  end  
end
