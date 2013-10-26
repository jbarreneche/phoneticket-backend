source 'https://rubygems.org'

ruby '2.0.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.0'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

gem "slim-rails"

gem 'activeadmin', github: 'gregbell/active_admin', branch: 'rails4'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

gem 'devise'

gem 'premailer-rails'
gem 'nokogiri'
gem 'zurb-foundation'
gem 'carrierwave'
gem 'cloudinary'

gem 'foreman'
gem 'unicorn'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
  gem 'simplecov', require: false
end

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the app server
gem 'unicorn'
gem 'guard-minitest'

group :test do
  gem 'turn'
end

group :development, :test do
  gem 'pry'
  gem 'mini_magick'
  gem 'dotenv-rails'
end

group :staging, :production do
  gem 'pg'
  gem 'rails_12factor'
end

group :assets do
  gem 'execjs'
  gem 'therubyracer'
end

group :development do
  # Use sqlite3 as the database for Active Record
  gem 'sqlite3'
  gem "mail_view"
  gem 'pry-remote'
end
