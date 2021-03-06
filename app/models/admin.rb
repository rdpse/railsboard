class Admin < ApplicationRecord
  include Autenticacao
  has_many :ticket_respostas, as: :respondente

  before_save { self.email = email.downcase }

  validates :nome, presence: true, length: { maximum: 50 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  
  has_secure_password
  validates :password, presence: true, length: { minimum: 8 }

end
