require 'test_helper'

class TimelineTest < ActiveSupport::TestCase

  def setup
    @user = users(:example)
    @post = @user.posts.build(content: "Lorem ipsum")
    @timeline = Timeline.create(user_id: @user.id, post_id: @post.id)
  end
  
  test "should be valid" do
    assert @timeline.valid?
  end

  test "user id should be present" do
    @timeline.user_id = nil
    assert_not @timeline.valid?
  end
end
