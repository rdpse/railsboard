class AddMostrarToProdutos < ActiveRecord::Migration[5.0]
  def change
    add_column :produtos, :mostrar, :boolean
  end
end
