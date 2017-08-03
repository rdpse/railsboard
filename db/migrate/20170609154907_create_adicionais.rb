class CreateAdicionais < ActiveRecord::Migration[5.0]
  def change
    create_table :adicionais do |t|
      t.belongs_to :produto_adicional, index: true
      t.belongs_to :host, index: true
      t.belongs_to :cliente, index: true
      t.text :descricao
      t.decimal :valor
      t.date :vencimento
      t.integer :status

      t.timestamps
    end
  end
end
