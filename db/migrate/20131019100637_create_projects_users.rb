class CreateProjectsUsers < ActiveRecord::Migration
  def change
    create_table :projects_users do |t|

      t.timestamps
    end
  end
end
