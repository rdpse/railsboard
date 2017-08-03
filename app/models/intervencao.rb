class Intervencao < ApplicationRecord
  belongs_to :host, required: false
  belongs_to :cliente, required: false

  enum status: [:agendada, :em_andamento, :finalizada]
end
