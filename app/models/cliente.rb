class Cliente < ApplicationRecord
  include Autenticacao
  attr_accessor :reset_token

  has_many :hosts
  has_many :adicionais, through: :hosts
  has_many :intervencoes
  has_many :faturas
  has_many :itens, through: :faturas
  has_many :produtos, through: :hosts
  has_many :dominios, through: :hosts

  has_many :tickets
  has_many :ticket_respostas, as: :respondente


  before_save { self.email = email.downcase }
  after_update :alterar_moeda_faturas, if: -> { moeda_changed? }

  validates :nome, presence: true, length: { maximum: 50 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

	has_secure_password
  validates :password, presence: true, length: { minimum: 8 }, allow_nil: true
  validates_confirmation_of :password, allow_nil: true

  enum moeda: [:BRL, :EUR]
  enum via_de_pagamento: [:CC, :TB]


  def create_reset_digest
    self.reset_token = Cliente.new_token
    update_columns(reset_digest: Cliente.digest(reset_token), reset_sent_at: Time.zone.now)
  end

  # TODO:
  # Diferenciar a moeda do utilizador, das suas faturas e, potencialmente, dos seus serviços
  # Se a moeda for alterada no perfil, perguntar ao cliente se quer que sejam
  # actualizados os valores das faturas retroactivamente
  # Se a moeda for alterada na fatura, alterar apenas os valores da fatura alterada
  # Se um serviço tiver moeda definida no seu atributo ":moeda", utilizá-la em vez da moeda definida
  # pelo utilizador.
  def alterar_moeda_faturas
    if self.moeda_changed?
      self.faturas.find_each do |f|
        f.update_attribute :moeda, self.moeda
      end
    end
  end

  def enviar_email_bem_vindo
    ClienteMailer.bem_vindo(self).deliver_now
  end

  def enviar_email_recuperacao
    ClienteMailer.recuperar_senha(self).deliver_now
  end

  def recuperacao_expirada?
    reset_sent_at < 2.hours.ago
  end
 
end
