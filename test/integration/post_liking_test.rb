require 'test_helper'

class PostLikingTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    sign_in users(:example)
    @user = users(:example)
    @post = posts(:most_recent)
    @like = likes(:one)
  end
  
  test "user should be able to like post" do
    assert @post.likes.count, 0
    assert_difference 'Like.count', 1 do
      post likes_path, params: { likeable_id: @post.id, likeable_type: "Post" }
    end
  end
  
  test "user should be able to unlike post" do
    assert_difference 'Like.count', -1 do
      like = @like
      delete like_path(like.id), params: { like_id: like.id }
    end
  end
end
