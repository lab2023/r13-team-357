class CreateChecklists < ActiveRecord::Migration
  def change
    create_table :checklists do |t|
      t.references :card, index: true
      t.string :title
      t.boolean :done
      t.datetime :done_at

      t.timestamps
    end
  end
end
