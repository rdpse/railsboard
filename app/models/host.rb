class Host < ApplicationRecord
  include Gestao
  include Faturacao
  include Monitoramento

  belongs_to :isp, optional: true
  belongs_to :cliente, required: false
  belongs_to :produto, required: false
  has_many :intervencoes
  has_many :itens, as: :servico
  has_many :faturas, through: :itens
  has_many :adicionais
  has_many :dominios

  enum modalidade: [:mensal, :trimestral, :semestral, :anual]
  enum status: [:activo, :cancelado]

  def ip_principal
    self.ipv4.nil? ? self.ipv6 : self.ipv4
  end

end
