namespace :dev do
  # Just run development env
  # This code run insert seed and agency data
  # A simple trick to over migration problem
  task :setup => [:environment] do
    raise 'Nah, You are at production' if Rails.env.production?
    Rake::Task['dev:kill_postgres_connections'].execute
    Rake::Task['db:drop'].execute
    Rake::Task['db:create'].execute
    Rake::Task['db:migrate'].execute
    Rake::Task['db:seed'].execute
    Rake::Task['dev:user'].execute
    Rake::Task['dev:admin'].execute
  end

  task :user => [:environment] do
    User.create!(email: 'muhammet.dilek@lab2023.com',     password: '12341234', password_confirmation: '12341234', name: 'Muhammet Dilek')
    User.create!(email: 'onur.oozgur.ozkan@lab2023.com',  password: '12341234', password_confirmation: '12341234', name: 'Onur Özgür Ozkan')
    User.create!(email: 'tayfun.ozis.erikan@lab2023.com', password: '12341234', password_confirmation: '12341234', name: 'Tayfun Ozis Erikan')
    User.create!(email: 'hamit.turku.kaya@lab2023.com',   password: '12341234', password_confirmation: '12341234', name: 'Hamit Türkü Kaya')
  end

  task :admin => [:environment] do
    Admin.create!(email: 'admin@ganban.com', password: '12341234', password_confirmation: '12341234')
  end

  task :kill_postgres_connections => [:environment] do
    db_name = "#{File.basename(Rails.root)}_#{Rails.env}"
    sh = <<EOF
ps xa \
  | grep postgres: \
  | grep #{db_name} \
  | grep -v grep \
  | awk '{print $1}' \
  | xargs kill
EOF
    puts `#{sh}`
  end

end