class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.references :card, index: true
      t.references :user, index: true
      t.attachment :file

      t.timestamps
    end
  end
end
