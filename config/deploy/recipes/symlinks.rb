namespace :symlinks do
  desc 'database.yml symlink'
  task :database do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end

  desc 'settings.yml symlink'
  task :settings do
    run "ln -nfs #{shared_path}/config/settings.yml #{release_path}/config/settings.yml"
  end

  after 'deploy:finalize_update', 'symlinks:database'
  after 'deploy:finalize_update', 'symlinks:settings'
end