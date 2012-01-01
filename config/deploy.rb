require 'bundler/capistrano'

set :application, "the swarm"
set :domain, "ec2-107-21-237-219.compute-1.amazonaws.com"

set :repository,  "/home/ubuntu/deploy.git"
set :local_repository,  "ssh://git@github.com:Bellwether/The-Swarm.git"

set :scm, :git
set :branch, "master"

ssh_options[:keys] = [File.join(ENV["HOME"], ".ec2", "keypairs", "theswarm.pem")] # local workstation ec2 keypair pem
ssh_options[:forward_agent] = true
set :deploy_via, :remote_cache
set :deploy_to, "/home/ubuntu/www"
set :user, "ubuntu"
set :use_sudo, false
set :scm_verbose, true

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