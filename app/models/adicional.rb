class Adicional < ApplicationRecord
  belongs_to :produto_adicional, required: false
  belongs_to :host, required: false
  belongs_to :cliente, required: false
  has_many :itens, as: :servico

  enum status: [:activo, :inactivo]
end
