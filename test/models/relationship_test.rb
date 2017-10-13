require 'test_helper'

class RelationshipTest < ActiveSupport::TestCase

  def setup
    @relationship = Relationship.new(requester_id: users(:example).id,
                                     receiver_id: users(:red).id)
  end

  test "should be valid" do
    assert @relationship.valid?
  end

  test "should require a requester_id" do
    @relationship.requester_id = nil
    assert_not @relationship.valid?
  end

  test "should require a receiver_id" do
    @relationship.receiver_id = nil
    assert_not @relationship.valid?
  end
  
  test "should default to non-confirmed friends" do
    assert_not @relationship.confirmed_friends?
  end
end