class CreateImportedFiles < ActiveRecord::Migration[8.0]
  def change
    create_table :imported_files do |t|
      t.string :file_hash
      t.string :email_from, null: true
      t.string :email_to, null: true
      t.string :email_subject, null: true
      t.text :email_body, null: true
      t.boolean :is_valid, default: false

      t.timestamps
    end
  end
end
