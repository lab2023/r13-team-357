class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :twitter
      t.string :stackoverflow
      t.string :github
      t.string :facebook
      t.string :blog
      t.string :linkedin
      t.text :bio
      t.string :name
      t.references :user, index: true

      t.timestamps
    end
  end
end
