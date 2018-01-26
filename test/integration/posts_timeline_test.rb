require 'test_helper'

class PostsTimelineTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  
  def setup
    sign_in users(:example)
    @user = users(:example)
  end
  
  test "timeline display" do
    get posts_path
    assert_template 'posts/index'
    @user.posts.paginate(page: 1).each do |post|
      assert_match post.content, response.body
    end
  end  
end
