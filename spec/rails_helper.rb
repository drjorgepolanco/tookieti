ENV['RAILS_ENV'] ||= 'test'
require 'spec_helper'
require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'

include ApplicationHelper
include UsersHelper

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.include SessionsHelper
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.include Capybara::DSL
  config.infer_spec_type_from_file_location!
end
