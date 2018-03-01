require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all
  include ApplicationHelper

  # Add more helper methods to be used by all tests here...
  
  def add_timeline(user, resource)
    Timeline.send(:create!, "user_id": user.id, 
                  "#{resource.class.to_s.downcase}_id": resource.id)
  end
end
