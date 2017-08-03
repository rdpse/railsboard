class AddAnexosToTicketRespostas < ActiveRecord::Migration[5.0]
  def change
    add_column :ticket_respostas, :anexos, :string
  end
end
