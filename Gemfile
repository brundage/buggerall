source 'https://rubygems.org'

gem 'chunky_png'
gem 'digest-sha3'
gem 'flarg'
gem 'rails', '3.2.9'

group :development do
  gem 'annotate'
  gem 'better_errors'
  gem 'binding_of_caller'  # for better_errors
  gem 'guard-rails-assets'
  gem 'rspec-rails'
  gem 'sqlite3'
  gem 'thin'
end


group :production do
  gem 'pg'
  gem 'taps'
  gem 'thin'
end


group :test do
  gem 'database_cleaner'
  gem 'factory_girl_rails'
  gem 'guard'
  gem 'guard-rails_best_practices'
  gem 'guard-rspec'
  gem 'rails_best_practices'
  gem 'rb-fchange', require: false  # Filesystem watcher for Guard on Windows
  gem 'rb-fsevent', require: false  # Filesystem watcher for Guard on OS X
  gem 'rb-inotify', require: false  # Filesystem watcher for Guard on Linux
  gem 'rspec'
  gem 'rspec-rails'
  gem 'shoulda-matchers'
  gem 'simplecov', require: false, git: 'git://github.com/colszowka/simplecov.git'
  gem 'sqlite3'
end
