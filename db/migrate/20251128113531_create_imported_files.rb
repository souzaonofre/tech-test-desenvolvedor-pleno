class CreateImportedFiles < ActiveRecord::Migration[8.0]
  def change
    create_table :imported_files do |t|
      t.string :file_hash, null: true
      
      t.string :email_from, null: true
      t.string :email_to, null: true
      t.string :email_subject, null: true
      t.text :email_body, null: true

      t.boolean :is_valid, default: false
      t.string :validation_source, null: true
      t.string :validation_error, null: true

      t.timestamps
    end
  end
end
