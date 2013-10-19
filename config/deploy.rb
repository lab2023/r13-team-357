require 'bundler/capistrano'
require 'capistrano/ext/multistage'
require 'whenever/capistrano'

load 'config/deploy/recipes/base'
load 'config/deploy/recipes/backup'
load 'config/deploy/recipes/check'
load 'config/deploy/recipes/db'
load 'config/deploy/recipes/nginx'
load 'config/deploy/recipes/symlinks'
load 'config/deploy/recipes/unicorn'
load 'config/deploy/recipes/assets'
load 'config/deploy/recipes/postgresql'

load 'config/deploy/recipes/monit'

set :stages, %w(staging production)

set :default_stage, 'staging'

default_run_options[:pty] = true

set :whenever_command, "bundle exec whenever"

set :application, "ganban"
set :user, "deployer"
set :deploy_to, "/home/#{user}/apps/#{application}"

set :deploy_via, :remote_cache
set :use_sudo, false

set :scm, "git"
set :repository, "git@github.com:railsrumble/r13-team-357.git"

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

set :maintenance_template_path, File.expand_path('../deploy/recipes/templates/maintenance.html.erb', __FILE__)

# Production
set :default_environment, {
    'PATH' => '$HOME/.rbenv/shims:$HOME/.rbenv/bin:$PATH'
}