require 'test_helper'

class PostTest < ActiveSupport::TestCase
  def setup
    @user = users(:example)
    @post = @user.posts.build(content: "Lorem ipsum")
  end
  
  test "should be valid" do
    assert @post.valid?
  end

  test "user id should be present" do
    @post.user_id = nil
    assert_not @post.valid?
  end

  test "content should be present" do
    @post.content = "   "
    assert_not @post.valid?
  end

  test "content should be at most 5000 characters" do
    @post.content = "a" * 5001
    assert_not @post.valid?
  end
  
  test "order should be most recent first" do
    assert_equal posts(:most_recent), Post.first
  end  
  
  test "should create timeline record after post creation" do
    assert_difference 'Timeline.count', 1 do
      Post.create!(user: @user, content: "Testing the timeline.")
    end
  end
end
