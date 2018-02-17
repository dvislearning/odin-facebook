require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  def setup
    @user = users(:example)
    @post = posts(:middle_hand)
    @comment = @user.comments.build(content: "Lorem ipsum", commentable_id: @post.id,
               commentable_type: "Post")
  end
  
  test "should be valid" do
    assert @comment.valid?
  end

  test "user id should be present" do
    @comment.user_id = nil
    assert_not @comment.valid?
  end
  
  test "commentable id should be present" do
    @comment.commentable_id = nil
    assert_not @comment.valid?
  end
  
  test "commentable type should be present" do
    @comment.commentable_type = nil
    assert_not @comment.valid?
  end  

  test "content should be present" do
    @post.content = "   "
    assert_not @post.valid?
  end

  test "content should be at most 5000 characters" do
    @post.content = "a" * 5001
    assert_not @post.valid?
  end
end
