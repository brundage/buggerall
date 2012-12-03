ENV["RAILS_ENV"] = "test"
require File.expand_path("../dummy/config/environment.rb",  __FILE__)

require 'rspec/rails'
require 'shoulda-matchers'

Rails.logger.level = 4

ENGINE_RAILS_ROOT = File.join(File.dirname(__FILE__), '..')

silence_stream STDOUT do
  load "#{ENGINE_RAILS_ROOT}/spec/dummy/db/schema.rb"
end

Dir[File.join(ENGINE_RAILS_ROOT, "spec/support/**/*.rb")].each {|f| require f }

RSpec.configure do |config|
  config.use_transactional_fixtures = true
end
