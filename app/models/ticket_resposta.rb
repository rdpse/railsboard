class TicketResposta < ApplicationRecord
  belongs_to :ticket, required: false
  belongs_to :respondente, polymorphic: true, required: false

  mount_uploaders :anexos, AnexoUploader
  serialize :anexos, JSON

  validates :mensagem, presence: true

  def notificar
    TicketMailer.nova_resposta(self.ticket, self).deliver_later
  end
end
