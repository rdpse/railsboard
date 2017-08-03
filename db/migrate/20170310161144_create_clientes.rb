class CreateClientes < ActiveRecord::Migration[5.0]
  def change
    create_table :clientes do |t|
      t.string :nome
      t.string :empresa
      t.string :email
      t.string :password_digest
      t.integer :moeda, default: 0 

      t.timestamps
    end
  end
end
