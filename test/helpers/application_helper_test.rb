require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test "full title helper" do
    assert_equal full_title,         "DV FB"
    assert_equal full_title("Example"), "Example | DV FB"
  end
end