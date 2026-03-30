require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'

require_relative '../config/environment'

abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'
require 'capybara/rails'
require 'capybara/rspec'
require 'simplecov'
SimpleCov.start 'rails'

# Dir[Rails.root.join('spec', 'support', '**', '*.rb')].each { |f| require f }

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end
RSpec.configure do |config|

  config.fixture_paths = [
    Rails.root.join('spec/fixtures')
  ]

  # config.file_fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true

  config.infer_spec_type_from_file_location!

  config.filter_rails_from_backtrace!
  config.include Capybara::DSL

  # Optional: configure a specific driver (e.g., headless Chrome)
  # Capybara.register_driver :headless_chrome do |app|
  #   options = Selenium::WebDriver::Chrome::Options.new(args: ['headless', 'disable-gpu', 'window-size=1280,800'])
  #   Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
  # end
  # Capybara.javascript_driver = :headless_chrome
  config.include Devise::Test::ControllerHelpers, type: :view
  config.include Devise::Test::ControllerHelpers, type: :controller
  config.include Rails.application.routes.url_helpers
  # config.include Devise::Test::IntegrationHelpers, type: :system
  # config.include Devise::Test::IntegrationHelpers, type: :request
  # config.include Warden::Test::Helpers
  config.include FactoryBot::Syntax::Methods
end
