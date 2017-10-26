require 'test_helper'

class PendingPageTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  
  def setup
    sign_in users(:friendless_example)
    @friendless_user = users(:friendless_example)
    @red = users(:red)
  end

  test 'pending page without pending requests' do
    get pending_path
    assert_template 'users/pending'
    assert_match "You have no pending friends", response.body
    # tests header notification
    assert_no_match "NEW FRIENDS!", response.body
  end
  
  test 'pending page with pending requests' do
    @red.sent_requests.create(receiver_id: @friendless_user.id)
    get pending_path
    assert_template 'users/pending'
    assert_select "div[id=?]", "confirm-#{@red.email}"
    assert_select "div[id=?]", "ignore-#{@red.email}"
    # tests header notification 
    assert_match "NEW FRIENDS!", response.body
  end  
end
