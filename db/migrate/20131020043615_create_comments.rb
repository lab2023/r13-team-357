class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :card, index: true
      t.references :user, index: true
      t.text :body

      t.timestamps
    end
  end
end
