require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  
  def setup
    sign_in users(:example)
    @user = users(:example)
  end
  
  test "index with pagination" do
    get users_path
    assert_template 'users/index'
    assert_select 'div.pagination', count: 2
    User.paginate(page: 1).each do |user|
      assert_select 'a[href=?]', user_path(user)
    end
    red = users(:red) # friends with example
    yellow = users(:yellow) # not friends with example
    assert_select "div[id=?]", "unfriend-#{red.id}"
    assert_select "div[id=?]", "friend-#{yellow.id}"
  end
  
end
