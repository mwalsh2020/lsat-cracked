source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.0'

gem 'rails', '6.1.3.2'

# System
gem "bootsnap", ">= 1.4.2", require: false
gem "pg"
gem "puma", "~> 4.1"

# Support
gem "acts_as_list"
gem "devise_invitable", "~> 2.0.0"
gem "httparty"
gem "money-rails"

# Security
gem "devise"
gem "pundit"

# Front-end
gem "jbuilder", "~> 2.7"
gem "sass-rails", ">= 6"
gem "simple_form"
gem "turbolinks", "~> 5"
gem "webpacker", "~> 4.0"
gem 'image_processing', '~> 1.2'
gem "tailwindcss-rails", "~> 0.3.3"

# External services
gem "postmark-rails"
gem "recaptcha"
gem "stripe"

# Jobs
gem "sidekiq"
gem "sidekiq-failures", "~> 1.0"

# CMS
gem "administrate", "~> 0.16.0"
gem 'administrate-field-active_storage', '~> 0.3.7'
gem "administrate-field-nested_has_many"
gem 'administrate-field-belongs_to_search'
gem "cocoon"

group :development, :test do
  gem "pry-byebug"
  gem "rspec-rails", "~> 4.0.1"
end

group :development, :staging do
  gem "faker", require: false
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
