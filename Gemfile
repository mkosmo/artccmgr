# frozen_string_literal: true

source "https://rubygems.org"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem "rails", "~> 5.2.0.rc1"
# Use postgresql as the database for Active Record
gem "pg", "~> 1.0"
# Use Puma as the app server
gem "puma", "~> 3.7"
# Use SCSS for stylesheets
gem "sass-rails", "~> 5.0"
# Use Uglifier as compressor for JavaScript assets
gem "uglifier", ">= 1.3.0"
# See https://github.com/rails/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
gem "coffee-rails", "~> 4.2"
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem "turbolinks", "~> 5"
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem "jbuilder", "~> 2.5"
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Audited for accountability
gem "audited", "~> 4.6"

# Bootstrap4 (and dependencies) for views
gem "bootstrap", "~> 4.0.0"
gem "jquery-rails"
gem "sprockets-rails", "~> 3.2.1"

# Devise for authentication
gem "devise"
gem "omniauth-vatsim"

# Pundit for authorization
gem "pundit"

# Site-wide settings
gem "rails-settings-cached"

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  gem "brakeman", require: false
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
  # Adds support for Capybara system testing and selenium driver
  gem "capybara", "~> 2.13"
  # Submit test coverage reports to Coveralls during CI
  gem "coveralls", require: false
  gem "factory_bot_rails"
  gem "faker", git: "https://github.com/stympy/faker.git", branch: "master"
  gem "haml-lint", require: false
  gem "pundit-matchers", "~> 1.4.1"
  gem "rails-controller-testing"
  gem "rspec-rails", "~> 3.7"
  gem "rubocop", require: false
  gem "rubocop-rails_config"
  gem "rubocop-rails"
  gem "selenium-webdriver"
  gem "shoulda-callback-matchers", "~> 1.1.1"
  gem "shoulda-matchers", "~> 3.1"
  gem "simplecov", require: false
end

group :development do
  gem "listen", ">= 3.0.5", "< 3.2"
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem "web-console", ">= 3.3.0"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
