ENV["RAILS_ENV"] ||= 'test'

require 'simplecov'
SimpleCov.start

require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'

Rails.logger.level = 4

silence_stream STDOUT do
  load "#{Rails.root}/db/schema.rb"
end

Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  config.mock_with :rspec
  config.order = :rand

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    full_example_description = "#{self.class.description} #{example.description}"
    Rails.logger.info("\n#{full_example_description}\n#{'-' * (full_example_description.length)}")

    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

end
