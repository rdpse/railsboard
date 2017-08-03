class AddViaDePagamentoToClientes < ActiveRecord::Migration[5.0]
 def change
    add_column :clientes, :via_de_pagamento, :integer, default: 0
  end
end
