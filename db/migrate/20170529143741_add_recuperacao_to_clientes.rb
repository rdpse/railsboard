class AddRecuperacaoToClientes < ActiveRecord::Migration[5.0]
  def change
    add_column :clientes, :reset_digest, :string
    add_column :clientes, :reset_sent_at, :datetime
  end
end
