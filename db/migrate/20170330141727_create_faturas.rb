class CreateFaturas < ActiveRecord::Migration[5.0]
  def change
    create_table :faturas do |t|
      t.belongs_to :cliente, index: true
      t.date :vencimento
      t.decimal :valor, precision: 12, scale: 2
      t.decimal :recebido, precision: 12, scale: 2, default: 0
      t.date :paga_em
      t.integer :via_de_pagamento
      t.integer :moeda
      t.integer :status, default: 0
      t.text :notas

      t.timestamps
    end
  end
end
