# RVM bootstrap
$:.unshift(File.expand_path("~/.rvm/lib"))
require 'rvm/capistrano'
set :rvm_ruby_string, '1.9.2@wallstickers'
set :rvm_type, :user

# bundler bootstrap
require 'bundler/capistrano'

set :stage, :production

set :domain, "wallstickers.pl"
set :application, domain
set :user, "deploy"

set :deploy_to, "/srv/apps/#{stage}/#{application}"

role :web, domain
role :app, domain
role :db, domain, :primary => true

set :app_server, :passenger
set :use_sudo, false

set :scm, :git
set :repository, "git@github.com:pithyless/wallstickers.git"
set :branch, "master"
set :deploy_via, :remote_cache
ssh_options[:forward_agent] = true

# TODO: temporary. How does Capistrano work with Rails 3.1 assets?
set :normalize_asset_timestamps, false
# see also:
# http://stackoverflow.com/questions/3023857/capistrano-and-deployment-of-a-website-from-github
# set :assets_dir, %w(public/files public/att)

namespace :deploy do
  task :start, :roles => :app do
    run "touch #{current_release}/tmp/restart.txt"
  end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{current_release}/tmp/restart.txt"
    # warm up passenger
    # run "curl -s 'http://wallstickers.pl' &> /dev/null; exit 0"
  end
end

after "deploy:update_code", "preconfigure"
desc "Configure the database and precompile assets"
task :preconfigure, :roles => :app do
  # symlink database.yml
  run "rm #{release_path}/config/database.yml && ln -sf #{shared_path}/database.yml #{release_path}/config/database.yml"

  # symlink uploads directory
  run "rm -r #{release_path}/public/uploads && ln -sf #{shared_path}/uploads #{release_path}/public/uploads"

  # compile assets
  run "cd #{current_release} && RAILS_ENV=production bundle exec rake assets:precompile"
end

require './config/boot'
require 'hoptoad_notifier/capistrano'
