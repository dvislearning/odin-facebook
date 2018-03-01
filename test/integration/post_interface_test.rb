require 'test_helper'

class PostInterfaceTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    sign_in users(:example)
    @user = users(:example)
    @example_post = posts(:middle_hand) # Post by Example_user
    add_timeline(@user, @example_post)
    @comment_1 = comments(:comment_one) # Comment by Example_user
    @comment_2 = comments(:comment_two) # Comment not by Example_user
  end

  test "post interface" do
    get posts_path
    assert_template 'posts/index'
    # Posts and comments are present
    assert_match @example_post.content, response.body
    assert_match @comment_1.content, response.body
    assert_match @comment_2.content, response.body
    # Can create posts
    content = "This is a post from example"
    # picture = fixture_file_upload('test/fixtures/rails.png', 'image/png')
    assert_difference 'Post.count', 1 do
      post posts_path, params: { post: { content: content} }
    end
    follow_redirect!
    assert_match content, response.body
    # Can comment on posts
    comment = "This is a comment from the post!"
    user_id = @user.id
    commentable_id = @example_post.id
    commentable_type = "Post"
    assert_difference 'Comment.count', 1 do
      post comments_path, params: { comment: { content: comment, user_id: user_id,
                                  commentable_id: commentable_id, 
                                  commentable_type: commentable_type} }    
    end
    follow_redirect!
    assert_match comment, response.body
  end
end
