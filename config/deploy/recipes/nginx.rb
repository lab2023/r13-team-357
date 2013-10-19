set_default(:project_domain) { Capistrano::CLI.ui.ask 'Project Domain=> ' }

namespace :nginx do
  desc 'Nginx setup.'
  task :setup do
    puts "Creating #{shared_path}/config/nginx.#{rails_env}.conf"
    template "nginx.#{rails_env}.erb", "#{shared_path}/config/nginx.#{rails_env}.conf"

    puts "Symlinks #{shared_path}/config/nginx.#{rails_env}.conf to /etc/nginx/sites-enabled/#{application}"
    sudo "ln -nfs #{shared_path}/config/nginx.#{rails_env}.conf /etc/nginx/sites-enabled/#{application}"

    puts 'Removing /etc/nginx/sites-enabled/default'
    sudo 'rm /etc/nginx/sites-enabled/default'
  end

  %w[start stop restart reload].each do |command|
    desc "Nginx #{command}"

    task command, role: :web do
      sudo "service nginx #{command}"
    end
  end

  after 'deploy:setup', 'nginx:setup'
  after 'deploy:setup', 'nginx:reload'
end