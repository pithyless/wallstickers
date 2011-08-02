require 'rubygems'
require 'spork'

Spork.prefork do
  ENV["RAILS_ENV"] ||= 'test'
  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'
  require 'shoulda/matchers/integrations/rspec'

  include Sorcery::TestHelpers::Rails

  Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

  RSpec.configure do |config|
    config.mock_with :rspec

    config.fixture_path = "#{::Rails.root}/spec/fixtures"
    config.use_transactional_fixtures = true

    config.after(:all) do
      # Get rid of uploaded images
      if Rails.env.test? || Rails.env.cucumber?
        FileUtils.rm_rf(Dir["#{Rails.root}/public/uploads/test"])
        FileUtils.rm_rf(Dir["#{Rails.root}/tmp/uploads/test"])
      end
    end
  end
end

Spork.each_run do
  Wallstickers::Application.reload_routes!
end
