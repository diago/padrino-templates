# Standard empty project with cucumber, factory girl, database cleaner, and spork
#
# The config files are pulled in for cucumber and rspec to have spork and factory girl ready to go
#

project :adapter    => :sqlite,
        :orm        => :activerecord,
        :test       => :cucumber,
        :script     => :jquery,
        :stylesheet => :compass

say "=> Adding test gems"
TEST_GEMS = <<-GEM
gem 'database_cleaner', :group => "test"
gem 'factory_girl', :group => "test"
gem 'spork', '~> 0.9.0rc', :group => "test"
GEM
inject_into_file destination_root('Gemfile'), TEST_GEMS, :after => "# Test requirements\n"

say "=> Fixing YAML issue"
YAML_FIX = <<-FIX
   YAML::ENGINE.yamler= 'syck'
FIX
inject_into_file destination_root('config/boot.rb'), YAML_FIX, :after => "Padrino.before_load do\n"

# bundle it
run_bundler

# Overwrite features/support/env.rb and 'spec/spec_helper.rb' with configured ones
['features/support/env.rb', 'spec/spec_helper.rb'].each do |f|
  say "=> Overwriting #{f}"
  remove_file f
  get "https://github.com/diago/padrino-templates/raw/master/#{f}", f
end

# Create dev and test db
rake "ar:create -e development"
rake "ar:create -e test"

# Create gitignore
say "=> Adding gitignore file"
GIT_IGNORE = <<-IGNORE
*.swp
.sass-cache*
IGNORE
create_file '.gitignore', GIT_IGNORE

# Git SCM
say "=> Initialize git"
git :init

# if no?('Use your global git configuration?')
#   user_name  = ask('Git user.name:')
#   user_email = ask('Git user.email')
#   @TODO figure out how to set configs
# end

git :add, '.'
git :commit, 'init commit'
