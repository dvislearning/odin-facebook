require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  
  def setup
    sign_in users(:example)
    @user = users(:example)
  end
  
  test "profile display" do
    get user_path(@user)
    assert_template 'users/show'
    assert_select 'title', full_title(@user.username)
    assert_select 'h1', text: @user.username
    assert_match @user.email, response.body
  end
  
  test "should display user's timeline" do
    get user_path(@user)
    @user.timeline.paginate(page: 1).each do |post|
      assert_match post.content, response.body
    end
  end
end
