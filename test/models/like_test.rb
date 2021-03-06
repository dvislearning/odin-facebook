require 'test_helper'

class LikeTest < ActiveSupport::TestCase
  def setup
    @user = users(:example)
    @post = posts(:left_hand)
    @like = @user.likes.build(likeable_id: @post.id, likeable_type: "Post")
  end
  
  test 'should be valid' do
    assert @like.valid?
  end
  
  test 'user_id should be present' do
    @like.user_id = nil
    assert_not @like.valid?
  end
  
  test 'likeable_id should be present' do
    @like.likeable_id = nil
    assert_not @like.valid?
  end
  
  test 'likeable_type should be present' do
    @like.likeable_type = nil
    assert_not @like.valid?
  end  
  
  test 'should not allow like of post by user twice' do
    second_like = @user.dup
    assert_not second_like.valid?
  end
end
