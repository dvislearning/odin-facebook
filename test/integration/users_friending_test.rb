
class FollowingTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    sign_in users(:example)
    @user = users(:example)
    @other = users(:yellow)
    @relationship = relationships(:three)
  end


  test "should send friend request to a user" do
    assert_difference 'Relationship.count', 1 do
      post relationships_path, params: { receiver_id: @other.id }
    end
    posted_relationship = Relationship.last
    assert_not posted_relationship.confirmed_friends    
  end
  
  
  test "should delete friendship with user" do
    assert_difference 'Relationship.count', -1 do
      delete relationship_path(@relationship.id), params: { relationship_id: @relationship.id }
    end
  end

end