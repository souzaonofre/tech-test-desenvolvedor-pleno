class CreateEmails < ActiveRecord::Migration[8.0]
  def change
    create_table :emails do |t|
      t.references :customer, index: true, foreign_key: true
      t.string :produto
      t.string :assunto
      t.string :contexto

      t.timestamps
    end
  end
end
