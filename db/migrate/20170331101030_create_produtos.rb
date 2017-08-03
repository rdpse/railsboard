class CreateProdutos < ActiveRecord::Migration[5.0]
  def change
    create_table :produtos do |t|
      t.string :nome
      t.decimal :espaco, precision: 18, scale: 2
      t.decimal :ram, precision: 18, scale: 2
      t.string :banda
      t.boolean :x2go
      t.decimal :valor, precision: 12, scale: 2

      t.timestamps
    end

    create_table :produto_adicionais do |t|
      t.string :nome
      t.text :descricao
      t.decimal :valor, precision: 12, scale: 2

      t.timestamps
    end

    create_join_table :produto_adicionais, :produtos do |t|
      t.index :produto_id
      t.index :produto_adicional_id
    end
  end
end
