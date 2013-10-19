class CreateProjectsUsersTable < ActiveRecord::Migration
  def change
    create_table 'projects_users', :id => false do |t|
      t.column :project_id, :integer
      t.column :user_id, :integer
    end
  end
end
