require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(username: "Example User", email: "user@example.com")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "username should be present" do
    @user.username = ""
    assert_not @user.valid?
  end
  
  test "username should be less than 51 characters long" do
    @user.username = "a" * 51
    assert_not @user.valid?
  end
  
  test "email should be present" do
    @user.email = "     "
    assert_not @user.valid?
  end
  
  test "email addresses should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end
  
  test "should find relationship when either requester or receiver calls it"  do
    user_1 = users(:example)
    user_2 = users(:red)
    relationship = Relationship.new(requester_id: user_1.id, receiver_id: user_2.id)
    assert_equal relationship.requester, user_1.find_relationship(user_2).first.requester
    assert_equal relationship.receiver, user_1.find_relationship(user_2).first.receiver
    assert_equal relationship.requester, user_2.find_relationship(user_1).first.requester
    assert_equal relationship.receiver, user_2.find_relationship(user_1).first.receiver
  end
  
  test "associated posts should be destroyed" do
    @user.save
    @user.posts.create!(content: "Lorem ipsum")
    assert_difference 'Post.count', -1 do
      @user.destroy
    end
  end  
end
