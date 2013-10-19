def set_default(name, *args, &block)
  set(name, *args, &block) unless exists?(name)
end

def template(from, to)
  erb = File.read(File.expand_path("../templates/#{from}", __FILE__))
  put ERB.new(erb).result(binding), to
end

#set :whenever_command, 'bundle exec whenever'
namespace :deploy do
  desc 'Install bundler'
  task :install_bundler, :roles => :app do
    run 'type -P bundle &>/dev/null || { gem install bundler --no-rdoc --no-ri; }'
  end

  desc 'Resque QUEUE Start'
  task :resque_setup, :roles => :db do
    run "cd #{release_path} && resque:work QUEUE='*'"
  end
end

after 'deploy', 'deploy:cleanup'
before 'deploy:cold', 'deploy:install_bundler'
before 'deploy', 'deploy:web:disable'
after 'deploy', 'deploy:web:enable'