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
    @friend_request = @red.sent_requests.create(receiver_id: @friendless_user.id)
    get pending_path
    assert_template 'users/pending'
    assert_match "NEW FRIENDS!", response.body
    assert_select "div[id=?]", "confirm-#{@red.id}"
    assert_select "div[id=?]", "ignore-#{@red.id}"
    patch relationship_path(@friend_request), params: { relationship_id: @friend_request.id }
    assert_equal true, Relationship.find(@friend_request.id).confirmed_friends
  end  
end
