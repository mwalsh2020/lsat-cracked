source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.7.1"

gem "rails", "~> 6.0.3", ">= 6.0.3.2"

# System
gem "pg"
gem "puma", "~> 4.1"
gem "bootsnap", ">= 1.4.2", require: false

# Support
gem "money-rails"
gem "acts_as_list"
gem 'devise_invitable', '~> 2.0.0'

# Security
gem "devise"
gem "pundit"

# Front-end
gem "simple_form"
gem "turbolinks", "~> 5"
gem "webpacker", "~> 4.0"
gem "jbuilder", "~> 2.7"
gem "sass-rails", ">= 6"

# External services
gem "postmark-rails"
gem "stripe"

group :development, :test do
  gem "pry-byebug"
  gem "rspec-rails", "~> 4.0.1"
end

group :development do
  gem "bullet"
  gem "listen", "~> 3.2"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
  gem "web-console", ">= 3.3.0"

  gem "dotenv-rails"

  gem "rubocop"
  gem "rubocop-rails"
end

group :test do
  gem "capybara", ">= 2.15"
  gem "selenium-webdriver"
  gem "webdrivers"
end

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
