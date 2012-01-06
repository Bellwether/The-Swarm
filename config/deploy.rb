require 'bundler/capistrano'

set :application, "the swarm"
set :domain, "ec2-107-21-237-219.compute-1.amazonaws.com"

set :repository,  "git@github.com:Bellwether/The-Swarm.git"

set :scm, :git
set :branch, "master"

default_run_options[:pty] = true
ssh_options[:keys] = [File.join(ENV["HOME"], ".ec2", "keypairs", "theswarm.pem")] # local workstation ec2 keypair pem
ssh_options[:forward_agent] = true
#set :deploy_via, :remote_cache

default_run_options[:pty] = true
set :deploy_to, "/home/ubuntu/www"
set :user, "ubuntu"
set :use_sudo, false
set :scm_verbose, true
set :git_enable_submodules, 1
set :keep_releases, 2

role :web, domain
role :app, domain
role :db,  domain, :primary => true

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

namespace :db do
  desc "Populates the Production Database"
  task :seed do
    puts "\n\n=== Populating the Production Database! ===\n\n"
    run "cd #{current_path}; rake db:seed RAILS_ENV=production"
  end
end