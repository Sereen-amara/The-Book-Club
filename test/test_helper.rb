ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

# Include SimpleCov for test coverage reporting
require "simplecov"
SimpleCov.start "rails"

# Enhance test output with Minitest Reporters
require "minitest/reporters"
Minitest::Reporters.use!(Minitest::Reporters::SpecReporter.new)

module ActiveSupport
  class TestCase
    # Include Devise test helpers for integration tests
    include Devise::Test::IntegrationHelpers

    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors, with: :threads)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...
  end
end