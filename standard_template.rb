project :adapter    => :sqlite,
        :orm        => :activerecord,
        :test       => :cucumber,
        :script     => :jquery,
        :stylesheet => :compass

TEST_GEMS = <<-GEM
gem 'database_cleaner', :group => "test"
gem 'factory_girl', :group => "test"
gem 'spork', '~> 0.9.0rc', :group => "test"
GEM
inject_into_file destination_root('Gemfile'), TEST_GEMS, :after => "# Test requirements\n"

YAML_FIX = <<-FIX
   YAML::ENGINE.yamler= 'syck'
FIX
inject_into_file destination_root('config/boot.rb'), YAML_FIX, :after => "Padrino.before_load do\n"

run_bundler

# Overwrite features/support/env.rb

# Overwrite spec/spec_helper.rb
