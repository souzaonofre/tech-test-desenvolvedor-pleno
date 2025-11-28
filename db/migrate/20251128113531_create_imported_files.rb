class CreateEmails < ActiveRecord::Migration[8.0]
  def change
    create_table :imported_files do |t|
      t.string :file_hash
      t.string :email_from, :null
      t.string :email_to, :null
      t.string :email_subject, :null
      t.text :email_body, :null
      t.boolean :is_valid, default: false

      t.timestamps
    end
  end
end
