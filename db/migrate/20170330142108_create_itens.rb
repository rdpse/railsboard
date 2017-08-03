class CreateItens < ActiveRecord::Migration[5.0]
  def change
    create_table :itens do |t|
      t.references :servico, polymorphic: true, index: true
      t.belongs_to :fatura, index: true
      t.belongs_to :cliente, index: true
      t.belongs_to :produto, index: true
      t.decimal :valor, precision: 12, scale: 2
      t.text :descricao
      t.integer :quantidade, default: 1
      t.boolean :pago, default: false

      t.timestamps
    end
  end
end
