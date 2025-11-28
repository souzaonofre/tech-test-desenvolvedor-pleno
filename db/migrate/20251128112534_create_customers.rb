class CreateCustomers < ActiveRecord::Migration[8.0]
  def change
    create_table :customers do |t|
      t.string :nome
      t.string :email
      t.string :telefone

      t.timestamps
    end
    add_index :customers, :email
  end
end
