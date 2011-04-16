PADRINO_ENV = 'test' unless defined?(PADRINO_ENV)

require 'rubygems'
require 'spork'

Spork.prefork do
  # Loading more in this block will cause your tests to run faster. However,
  # if you change any configuration or code from libraries loaded here, you'll
  # need to restart spork for it take effect.
  
  require File.expand_path(File.dirname(__FILE__) + "/../../config/boot")

  require 'capybara/cucumber'
  require 'rspec/expectations'

  # Database cleaner
  require 'database_cleaner'
  require 'database_cleaner/cucumber'
  DatabaseCleaner.strategy = :transaction

  # Factory Girl
  require 'factory_girl'
  factories = Padrino.mounted_root + '/spec/factories.rb'
  require factories if File.exists?(factories)
  require 'factory_girl/step_definitions'

  ##
  # You can handle all padrino applications using instead:
  #   Padrino.application
  Capybara.app = Padrino.application
  # Capybara.current_driver = :selenium

end

Spork.each_run do
  # This code will be run each time you run your specs.

end
