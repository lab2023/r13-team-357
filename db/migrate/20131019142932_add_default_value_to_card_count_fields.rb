class AddDefaultValueToCardCountFields < ActiveRecord::Migration
  def change
    change_column :cards, :checklist_done_count, :integer, default: 0
    change_column :cards, :checklist_total_count, :integer, default: 0
    change_column :cards, :comment_count, :integer, default: 0
    change_column :cards, :document_count, :integer, default: 0
  end
end
