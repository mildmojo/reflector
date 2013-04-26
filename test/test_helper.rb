ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

require 'timecop'
require 'test-unit'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  class VerificationError < StandardError; end

  def verify(bool, msg = nil)
    unless bool
      raise VerificationError, msg
    end
  end

  def verify_false(bool, msg = nil)
    verify !bool, msg
  end

  def json_body
    JSON.parse(@response.body)
  end
end

class ActiveRecord::Base
  mattr_accessor :shared_connection
  @@shared_connection = nil

  def self.connection
    @@shared_connection || retrieve_connection
  end
end

# Forces all threads to share the same connection. This works on
# Capybara because it starts the web server in a thread.
ActiveRecord::Base.shared_connection = ActiveRecord::Base.connection

# Fix 'table not found' errors for in-memory SQLite DB.
ActiveRecord::Schema.verbose = false
load Rails.root.join('db/schema.rb')
