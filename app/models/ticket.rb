class Ticket < ApplicationRecord
  has_many :ticket_respostas 
  belongs_to :cliente
  
  accepts_nested_attributes_for :ticket_respostas

  enum status: [:aberto, :respondido, :em_progresso, :fechado]

  validates :assunto, presence: true

  def notificar_admin
    TicketMailer.novo_ticket(self).deliver_later
  end

end
