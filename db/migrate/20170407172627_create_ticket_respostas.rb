class CreateTicketRespostas < ActiveRecord::Migration[5.0]
  def change
    create_table :ticket_respostas do |t|
      t.references :respondente, polymorphic: true, index: true
      t.belongs_to :ticket, index: true
      t.text :mensagem

      t.timestamps
    end
  end
end
