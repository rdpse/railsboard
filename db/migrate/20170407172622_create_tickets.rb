class CreateTickets < ActiveRecord::Migration[5.0]
  def change
    create_table :tickets do |t|
      t.belongs_to :cliente, index: true
      t.string :nome
      t.string :email
      t.string :assunto
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
