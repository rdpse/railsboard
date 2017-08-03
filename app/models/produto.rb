class Produto < ApplicationRecord
  has_many :hosts
  has_many :clientes, through: :hosts
  has_and_belongs_to_many :produto_adicionais, required: false
end
