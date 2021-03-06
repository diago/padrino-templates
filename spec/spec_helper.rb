PADRINO_ENV = 'test' unless defined?(PADRINO_ENV)

require 'rubygems'
require 'spork'

Spork.prefork do
  # Loading more in this block will cause your tests to run faster. However,
  # if you change any configuration or code from libraries loaded here, you'll
  # need to restart spork for it take effect.
  require File.expand_path(File.dirname(__FILE__) + "/../config/boot")
  require 'database_cleaner'
  require 'factory_girl'
  require File.expand_path(File.dirname(__FILE__) + "/factories.rb")

  RSpec.configure do |conf|
    conf.include Rack::Test::Methods

    conf.before(:suite) do
      DatabaseCleaner.strategy = :transaction
    end

    conf.before(:each) do
      DatabaseCleaner.start
    end

    conf.after(:each) do
      DatabaseCleaner.clean
    end
  end

  def app
    ##
    # You can handle all padrino applications using instead:
    Padrino.application
  end

end

Spork.each_run do
  # This code will be run each time you run your specs.

end
