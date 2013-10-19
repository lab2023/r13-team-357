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
    guest = User.find_by_email('info@lab2023.com')
    muhammet  = User.create!(email: 'muhammet.dilek@lab2023.com',     password: '12341234', password_confirmation: '12341234', name: 'Muhammet Dilek')
    onur      = User.create!(email: 'onur.ozgur.ozkan@lab2023.com',   password: '12341234', password_confirmation: '12341234', name: 'Onur Özgür Ozkan')
    tayfun    = User.create!(email: 'tayfun.ozis.erikan@lab2023.com', password: '12341234', password_confirmation: '12341234', name: 'Tayfun Ozis Erikan')
    hamit     = User.create!(email: 'hamit.turku.kaya@lab2023.com',   password: '12341234', password_confirmation: '12341234', name: 'Hamit Türkü Kaya')

    project = guest.own_projects.create(name: 'Blog', description: 'My personel website', owner_id: guest.id)
    project.users << guest
    project.users << onur
    project.users << tayfun
    project.users << hamit
    project.users << muhammet

    list_1 = project.lists.create(name: 'To Do')
    list_1.cards.create(title: 'Create Project With Cybele', owner_id: guest.id)
    list_1.cards.create(title: 'Setup Mandril', owner_id: muhammet.id)
    list_1.cards.create(title: 'Setup Bulutfon', owner_id: muhammet.id, assignment_id: onur.id)
    list_2 = project.lists.create(name: 'In Progress')
    list_2.cards.create(title: 'Setup Capistrano', owner_id: muhammet.id)

    list_3 =project.lists.create(name: 'Done')
    list_3.cards.create(title: 'Get Domain', owner_id: tayfun.id, assignment_id: hamit.id)
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