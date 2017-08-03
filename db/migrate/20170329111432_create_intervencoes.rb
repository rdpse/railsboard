class CreateIntervencoes < ActiveRecord::Migration[5.0]
  def change
    create_table :intervencoes do |t|
      t.belongs_to :cliente, index: true
      t.belongs_to :host, index: true
      t.string :nome
      t.text :descricao
      t.integer :estado
      t.datetime :agendado_para

      t.timestamps
    end
  end
end
