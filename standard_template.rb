# Standard empty project with cucumber, factory girl, database cleaner, and spork
#
# The config files are pulled in for cucumber and rspec to have spork and factory girl ready to go
#

project :adapter    => :sqlite,
        :orm        => :activerecord,
        :test       => :cucumber,
        :script     => :jquery,
        :stylesheet => :compass

say "Adding test gems"
TEST_GEMS = <<-GEM
gem 'database_cleaner', :group => "test"
gem 'factory_girl', :group => "test"
gem 'spork', '~> 0.9.0rc', :group => "test"
GEM
inject_into_file destination_root('Gemfile'), TEST_GEMS, :after => "# Test requirements\n"

say "Fixing YAML issue"
YAML_FIX = <<-FIX
   YAML::ENGINE.yamler= 'syck'
FIX
inject_into_file destination_root('config/boot.rb'), YAML_FIX, :after => "Padrino.before_load do\n"

run_bundler

# Overwrite features/support/env.rb
say "=> Overwriting cucumber env.rb"
file_env = 'features/support/env.rb'
remove_file(file_env)
get 'https://github.com/diago/padrino-templates/raw/master/features/support/env.rb', file_env

# Overwrite spec/spec_helper.rb
say "=> Overwriting rspec spec_helper.rb"
file_spec_helper = 'spec/spec_helper.rb'
remove_file(file_spec_helper)
get 'https://github.com/diago/padrino-templates/raw/master/spec/spec_helper.rb', file_spec_helper


# Git SCM
git :init

# say
# if no?('Use your global git configuration?')
#   user_name  = ask('Git user.name:')
#   user_email = ask('Git user.email')
#   @TODO figure out how to set configs
# end

git :add, '.'
git :commit, 'init commit'
