class AddRememberDigestToClientes < ActiveRecord::Migration[5.0]
  def change
    add_column :clientes, :remember_digest, :string
  end
end
