class CreateLists < ActiveRecord::Migration
  def change
    create_table :lists do |t|
      t.string :name
      t.integer :sort
      t.references :project, index: true

      t.timestamps
    end
  end
end
