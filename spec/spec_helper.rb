# Include test coverage in report.
require 'simplecov'
require 'simplecov-console'
SimpleCov.start 'rails' do
  SimpleCov.formatter = SimpleCov::Formatter::Console
end

# Load supporting files in our test suite.
Dir["./spec/support/**/*.rb"].each { |f| require f }

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
end
