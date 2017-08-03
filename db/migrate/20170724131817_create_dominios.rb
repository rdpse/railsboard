class CreateDominios < ActiveRecord::Migration[5.0]
  def change
    create_table :dominios do |t|
      t.belongs_to :host, index: true
      t.belongs_to :cliente, index: true
      t.string :nome
      t.boolean :cloudflare
      t.string :cloudflare_zone_id

      t.timestamps
    end
  end
end
