namespace :db do
  desc 'Setup db configuration.'
  task :setup do
    run "mkdir -p #{shared_path}/config"
    template 'database.yml.erb', "#{shared_path}/config/database.yml"
  end

  after 'deploy:setup', 'db:setup'
end
