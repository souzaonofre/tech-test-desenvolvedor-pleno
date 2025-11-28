class CreateProducts < ActiveRecord::Migration[8.0]
  def change
    create_table :products do |t|
      t.references :customer, index: true, foreign_key: true
      t.string :produto
      t.string :intencao

      t.timestamps
    end
  end
end
