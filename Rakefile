# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.
if ENV['COVERAGE']
  require 'simplecov'
  SimpleCov.start "rails"
end

require File.expand_path('../config/application', __FILE__)

PhoneTicket::Application.load_tasks
