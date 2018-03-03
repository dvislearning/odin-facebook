require 'test_helper'

class HeaderLayoutTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    sign_in users(:example)
    @user = users(:example)
    @other = users(:purple)
  end
  
  test 'header links without pending' do
    get root_path
    assert_template 'posts/index'
    assert_select "a[href=?]", root_path
    assert_select "a[href=?]", users_path
    assert_select "a[href=?]", user_path(@user)
    assert_select "a[href=?]", users_path
    assert_select "a[href=?]", edit_user_registration_path, text: "Settings"  
    assert_select "a[href=?]", destroy_user_session_path, text: "Log out"
    # No pending friends link when there are no pending friends
    assert_select "a[href=?]", pending_path, count: 0
  end
    
  test 'header links with pending' do  
    # "New Friends" link should appear when receiving friend request
    Relationship.create(requester: @other, receiver: @user)
    get root_path
    assert_select "a[href=?]", pending_path, text: "NEW FRIENDS!"
    get pending_path
    assert_select "a[href=?]", user_path(@other)
  end
end
