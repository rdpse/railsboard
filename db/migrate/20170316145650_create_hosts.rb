class CreateHosts < ActiveRecord::Migration[5.0]
  def change
    create_table :hosts do |t|
      t.belongs_to :isp, index: true
      t.belongs_to :cliente, index: true
      t.belongs_to :produto, index: true
      t.string :reverse
      t.string :isp_hostname
      t.integer :isp_server_id
      t.string  :hostname
      t.string  :os
      t.string :ipv4
      t.string :ipv6
      t.decimal :hdd_total, precision: 18, scale: 2
      t.decimal :ram_total, precision: 18, scale: 2
      t.decimal :hdd_utilizado, precision: 18, scale: 2
      t.decimal :ram_utilizado, precision: 18, scale: 2
      t.decimal :trafego_usado, precision: 18, scale: 2
      t.boolean :reiniciando, default: false
      t.string :user
      t.string :password
      t.decimal :valor, precision: 12, scale: 2
      t.date :vencimento
      t.integer :modalidade
      t.boolean :rtorrent, default: true
      t.boolean :windows, default: false
      t.boolean :alive
      t.text :notas

      t.timestamps
    end
  end
end
