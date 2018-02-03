require 'test_helper'

class PostsTimelineTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  
  def setup
    sign_in users(:example)
    @user = users(:example)
    @example_post = posts(:middle_hand) # Post by Example_user
    @red_post = posts(:left_hand) # Post by Example's Friend    
    @yellow_post = posts(:yellow_post) # Post by someone not Example's Friend
  end
  
  test "timeline display" do
    get posts_path
    assert_template 'posts/index'
    assert_match @example_post.content, response.body
    assert_match @red_post.content, response.body
    assert_no_match @yellow_post.content, response.body
    @user.timeline.paginate(page: 1).each do |post|
      assert_match post.content, response.body
    end
  end  
end

# Write tests checking if friends and non friends appear on timeline.