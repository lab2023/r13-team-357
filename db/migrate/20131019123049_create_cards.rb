class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.integer :owner_id, index: true
      t.integer :assignment_id, index: true
      t.references :list, index: true
      t.string :title
      t.text :body
      t.date :due_date
      t.boolean :done
      t.integer :comment_count
      t.integer :document_count
      t.integer :checklist_total_count
      t.integer :checklist_done_count
      t.boolean :private
      t.integer :sort

      t.timestamps
    end
  end
end
