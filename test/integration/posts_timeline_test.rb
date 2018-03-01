require 'test_helper'

class PostsTimelineTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  
  def setup
    sign_in users(:example)
    @user = users(:example)
    @example_post = posts(:middle_hand) # Post by Example_user
    add_timeline(@user, @example_post)
    @red_post = posts(:left_hand) # Post by Example's Friend   
    add_timeline(users(:red), @red_post)
    @yellow_post = posts(:yellow_post) # Post by someone not Example's Friend
    add_timeline(users(:yellow), @yellow_post)
  end
  
  test "timeline display" do
    get posts_path
    assert_template 'posts/index'
    assert_match @example_post.content, response.body
    assert_match @red_post.content, response.body
    assert_no_match @yellow_post.content, response.body
    @user.timeline.paginate(page: 1).each do |post|
      resource = post.picture_id.nil? ? Post.find(post.post_id) : 
                 Picture.find(post.picture_id)
      assert_match resource.content, response.body if resource.class == Post
    end
  end  
end